import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_cubit.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_state.dart';
import 'package:flutter_boilerplate/feature_my_courses/utils/my_courses_strings.dart';

/// Filter row directly under the page title.
///
/// Layout (matches the target design):
///   ┌─────────────────────────────────────────────────────────┐
///   │ 🔍  Filter my courses                                  │  ← search input
///   └─────────────────────────────────────────────────────────┘
///   ┌──────────────────────┐                  ┌──┐ ┌──┐
///   │ In progress      ▾   │                  │↕ │ │▦ │  ← dropdown + sort + grid
///   └──────────────────────┘                  └──┘ └──┘
///
/// Implementation notes:
///   • The cubit is captured once in [initState] so callbacks never
///     call `context.read<MyCoursesCubit>()` from a stale element.
///   • A single top-level [BlocBuilder] drives the UI; we read every
///     field we need from the latest state at build time.
class MyCoursesFilterRow extends StatefulWidget {
  const MyCoursesFilterRow({super.key});

  @override
  State<MyCoursesFilterRow> createState() => _MyCoursesFilterRowState();
}

class _MyCoursesFilterRowState extends State<MyCoursesFilterRow> {
  late final TextEditingController _controller;
  // Captured once at mount time so onChanged / onPressed handlers can
  // call the cubit without depending on a specific BuildContext.
  late final MyCoursesCubit _cubit;

  // Key for the status chip — used by the dropdown menu to anchor
  // itself under the chip regardless of layout changes.
  final GlobalKey _statusChipKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MyCoursesCubit>();
    _controller = TextEditingController(text: _cubit.state.searchQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCoursesCubit, MyCoursesState>(
      builder: (context, state) {
        // Keep controller text in sync with state changes that did not
        // originate from the TextField.
        if (state.searchQuery != _controller.text) {
          _controller.value = TextEditingValue(
            text: state.searchQuery,
            selection: TextSelection.collapsed(
              offset: state.searchQuery.length,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SearchField(
                controller: _controller,
                onChanged: _cubit.setSearchQuery,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _StatusFilterChip(
                    chipKey: _statusChipKey,
                    value: state.statusFilter,
                    onChanged: _cubit.setStatusFilter,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: MyCoursesStrings.sortTooltip,
                    icon: const Icon(Icons.sort),
                    onPressed: () => _showSortSheet(context, state.sortOrder),
                  ),
                  SizedBox(width: 4.w),
                  IconButton(
                    tooltip: MyCoursesStrings.layoutGridTooltip,
                    icon: Icon(
                      state.viewMode == MyCoursesViewMode.list
                          ? Icons.grid_view
                          : Icons.view_list,
                    ),
                    onPressed: _cubit.toggleViewMode,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Soft neutral border to match the design's subtle grey outline.
    final borderColor = isDark
        ? const Color(0xFF2A2A2E)
        : const Color(0xFFE5E7EB);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20.sp,
            color: isDark
                ? theme.colorScheme.onSurfaceVariant
                : const Color(0xFF6B7280),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: MyCoursesStrings.filterHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                filled: false,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Status filter chip with a custom dropdown that mirrors the
/// eLearning23 reference mock: anchored directly under the chip, same
/// width, peach-highlighted selected row with an orange left-border
/// indicator, thin dividers between rows, triangle that flips between
/// down (closed) and up (open).
class _StatusFilterChip extends StatefulWidget {
  const _StatusFilterChip({
    required this.chipKey,
    required this.value,
    required this.onChanged,
  });

  final GlobalKey chipKey;
  final MyCoursesStatusFilter value;
  final ValueChanged<MyCoursesStatusFilter> onChanged;

  @override
  State<_StatusFilterChip> createState() => _StatusFilterChipState();
}

class _StatusFilterChipState extends State<_StatusFilterChip> {
  bool _isOpen = false;

  Future<void> _toggle(BuildContext context) async {
    if (_isOpen) return;
    setState(() => _isOpen = true);

    // Compute the chip's on-screen position so the menu can anchor
    // directly under it with the same width.
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    final box = widget.chipKey.currentContext?.findRenderObject() as RenderBox?;
    if (overlay == null || box == null) {
      setState(() => _isOpen = false);
      return;
    }
    final topLeft = box.localToGlobal(Offset.zero, ancestor: overlay);
    final bottomRight =
        box.localToGlobal(box.size.bottomRight(Offset.zero), ancestor: overlay);

    final selected = await showMenu<MyCoursesStatusFilter>(
      context: context,
      position: RelativeRect.fromLTRB(
        topLeft.dx,
        bottomRight.dy + 4,
        overlay.size.width - bottomRight.dx,
        overlay.size.height - bottomRight.dy,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      items: [
        for (final entry in MyCoursesStatusFilter.values)
          PopupMenuItem<MyCoursesStatusFilter>(
            value: entry,
            padding: EdgeInsets.zero,
            child: _StatusMenuRow(
              label: entry.label,
              isSelected: entry == widget.value,
            ),
          ),
      ],
    );

    if (!mounted) return;
    setState(() => _isOpen = false);
    if (selected != null && selected != widget.value) {
      widget.onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF2A2A2E)
        : const Color(0xFFE5E7EB);
    return InkWell(
      key: widget.chipKey,
      borderRadius: BorderRadius.circular(8),
      onTap: () => _toggle(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.value.label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 20.sp,
              color: theme.colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

/// One row inside the status dropdown menu.
///
/// Selected row: peach background + orange left-border indicator.
/// Unselected: white background, dark text, thin grey bottom divider.
class _StatusMenuRow extends StatelessWidget {
  const _StatusMenuRow({
    required this.label,
    required this.isSelected,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // When selected, paint the entire row with a stronger peach background
    // and a prominent orange left indicator that spans the full row height.
    // The orange stripe is layered on top of the peach via a Row of
    // [stripe, content] so it stretches from top to bottom — not just the
    // text area.
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF5E6DA) : Colors.white,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Orange left indicator — full height of the row, 6 px wide.
            Container(
              width: 6,
              color: isSelected
                  ? const Color(0xFFFF6F1A)
                  : Colors.transparent,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showSortSheet(
  BuildContext context,
  MyCoursesSortOrder current,
) async {
  final cubit = context.read<MyCoursesCubit>();
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Text(
                MyCoursesStrings.sortTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            RadioListTile<MyCoursesSortOrder>(
              value: MyCoursesSortOrder.lastAccessed,
              groupValue: current,
              onChanged: (v) {
                if (v != null) cubit.setSortOrder(v);
                Navigator.of(sheetContext).pop();
              },
              title: const Text(MyCoursesStrings.sortLastAccessed),
            ),
            RadioListTile<MyCoursesSortOrder>(
              value: MyCoursesSortOrder.titleAsc,
              groupValue: current,
              onChanged: (v) {
                if (v != null) cubit.setSortOrder(v);
                Navigator.of(sheetContext).pop();
              },
              title: const Text(MyCoursesStrings.sortTitleAsc),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
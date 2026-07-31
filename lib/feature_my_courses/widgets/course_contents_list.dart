import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/course_contents_cubit.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/course_contents_state.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';

/// Renders the Course Contents list on the course detail page.
///
/// Layout matches the reference screenshots from the real Moodle
/// mobile app:
///   * Each section is a collapsible card with a chevron and the
///     section name. The first section is open by default; the rest
///     are collapsed.
///   * Each module row has a **modname-driven** coloured Material
///     icon on the left (forum→chat, assign→upload, page→document,
///     resource→play-in-document, …). The modname values come from
///     the API — only the icon mapping is client-side.
///   * Module rows tap to launch `module.url`; file chips tap to
///     launch `file.fileurl` with the user's `wstoken` appended.
///
/// **Anchor registry**: every section header and every module row is
/// registered with a [GlobalKey] in [_anchorKeys] so the Course Index
/// bottom sheet can scroll-jump to a specific row on tap. Use the
/// public [CourseContentsListState.scrollToAnchor] entry point.
class CourseContentsList extends StatefulWidget {
  /// Creates a [CourseContentsList].
  const CourseContentsList({super.key});

  @override
  State<CourseContentsList> createState() => CourseContentsListState();
}

class CourseContentsListState extends State<CourseContentsList> {
  /// Maps an anchor id (`section:<sectionId>` or `module:<moduleId>`)
  /// Maps an anchor id (`section:<sectionId>` or `module:<moduleId>`)
  /// to the [GlobalKey] attached to its row, so the bottom sheet can
  /// scroll into view.
  final Map<String, GlobalKey> _anchorKeys = {};

  /// Adds an anchor and returns its key (one key per anchor id).
  GlobalKey _anchorKeyFor(String id) {
    return _anchorKeys.putIfAbsent(id, () => GlobalKey());
  }

  /// Public hook for the parent page to scroll an anchor into view.
  ///
  /// The parent (course detail page) forwards an anchor id returned
  /// from `CourseIndexDrawer` to this method, and we run
  /// [Scrollable.ensureVisible] against the matching row.
  void scrollToAnchor(String id) {
    final key = _anchorKeys[id];
    if (key == null) return;
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseContentsCubit, CourseContentsState>(
      builder: (context, state) {
        final cubit = context.read<CourseContentsCubit>();
        // Every branch returns a sliver — the parent page hosts us
        // inside a `CustomScrollView`'s `slivers` list, so anything
        // that isn't a sliver (Center, Column, etc.) throws
        // "RenderViewport expected a child of type RenderSliver"
        // at runtime. Wrap non-sliver children in `SliverToBoxAdapter`
        // or `SliverFillRemaining` before returning.
        if (state.isLoading && state.sections.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.errorMessage != null && state.sections.isEmpty) {
          return SliverToBoxAdapter(
            child: _ErrorView(
              message: state.errorMessage!,
              onRetry: () => cubit.refresh(cubit.courseIdForRetry),
            ),
          );
        }
        if (state.sections.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        // Build a flat list of widgets so we can render everything
        // inside one continuous SliverList (the page already wraps
        // us in a CustomScrollView, so no nested ListView).
        final widgets = <Widget>[];
        for (var i = 0; i < state.sections.length; i++) {
          final s = state.sections[i];
          final anchorId = 'section:${s.id}';
          widgets.add(
            _CollapsibleSectionTile(
              section: s,
              anchorKey: _anchorKeyFor(anchorId),
              initiallyExpanded: i == 0,
              cubit: cubit,
              moduleAnchorKeyFor: (m) => _anchorKeyFor('module:${m.id}'),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildListDelegate(widgets),
        );
      },
    );
  }
}

/// Single collapsible section.
class _CollapsibleSectionTile extends StatefulWidget {
  const _CollapsibleSectionTile({
    required this.section,
    required this.anchorKey,
    required this.initiallyExpanded,
    required this.cubit,
    required this.moduleAnchorKeyFor,
  });

  final CourseSectionEntity section;
  final GlobalKey anchorKey;
  final bool initiallyExpanded;
  final CourseContentsCubit cubit;
  final GlobalKey Function(CourseModuleEntity) moduleAnchorKeyFor;

  @override
  State<_CollapsibleSectionTile> createState() =>
      _CollapsibleSectionTileState();
}

class _CollapsibleSectionTileState extends State<_CollapsibleSectionTile> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF2A2A2E)
        : const Color(0xFFE5E7EB);

    final hasContent =
        widget.section.name.isNotEmpty || widget.section.modules.isNotEmpty;
    if (!hasContent) return const SizedBox.shrink();

    return Container(
      key: widget.anchorKey,
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  // Circular chevron container — mirrors the reference
                  // screenshot where the toggle sits in a soft circle
                  // on the left of the section title.
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: AnimatedRotation(
                      turns: _expanded ? 0.25 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.section.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (widget.section.modules.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${widget.section.modules.length}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: _expanded
                ? Column(
                    children: [
                      Divider(height: 1, color: borderColor),
                      ...widget.section.modules.map(
                        (m) => _ModuleRow(
                          module: m,
                          anchorKey: widget.moduleAnchorKeyFor(m),
                          cubit: widget.cubit,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

/// One module inside a section.
class _ModuleRow extends StatelessWidget {
  const _ModuleRow({
    required this.module,
    required this.anchorKey,
    required this.cubit,
  });

  final CourseModuleEntity module;
  final GlobalKey anchorKey;
  final CourseContentsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dividerColor =
        isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE5E7EB);

    return Column(
      key: anchorKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => _openModule(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ModnameIcon(modname: module.modname),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      if (module.dateStart != null || module.dateEnd != null) ...[
                        const SizedBox(height: 6),
                        if (module.dateStart != null)
                          _DateLine(
                            label: 'Opened',
                            date: module.dateStart!,
                          ),
                        if (module.dateEnd != null)
                          _DateLine(
                            label: 'Due',
                            date: module.dateEnd!,
                          ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _ModuleTrailing(
                  module: module,
                ),
              ],
            ),
          ),
        ),
        // File chips: one outlined full-width row per chip, hanging
        // off the module row like a child list. Tapping a chip opens
        // the file in the OS browser (with the user's wstoken
        // appended).
        if (_chips(context, module).isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final chip in _chips(context, module))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: chip,
                  ),
              ],
            ),
          ),
        Divider(height: 1, color: dividerColor, indent: 14, endIndent: 14),
      ],
    );
  }

  List<Widget> _chips(BuildContext context, CourseModuleEntity m) {
    final badge = m.activityBadgeContent;
    final chips = <Widget>[];
    if (badge != null && badge.isNotEmpty) {
      final onTap = m.contents.isNotEmpty
          ? () => _openFile(context, m.contents.first)
          : null;
      chips.add(_FileChip(label: badge, onTap: onTap));
    }
    for (final f in m.contents) {
      chips.add(_FileChip(
        label: f.filename.isNotEmpty ? f.filename : '',
        onTap: () => _openFile(context, f),
      ));
    }
    return chips
        .where(
          (c) => c is _FileChip && (c).label.isNotEmpty,
        )
        .toList(growable: false);
  }

  Future<void> _openModule(BuildContext context) async {
    final url = module.url;
    if (url == null || url.isEmpty) return;
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open this activity.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openFile(
    BuildContext context,
    CourseContentFileEntity file,
  ) async {
    final raw = file.fileurl;
    if (raw == null || raw.isEmpty) return;
    final token = await cubit.getTokenForLaunches();
    final sep = raw.contains('?') ? '&' : '?';
    final url = '$raw${sep}token=$token';
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open this file.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

/// Right-side trailing column for a module row: completion checkmark
/// (when present) or a file-count badge (when the module has more
/// than one file).
class _ModuleTrailing extends StatelessWidget {
  const _ModuleTrailing({required this.module});

  final CourseModuleEntity module;

  @override
  Widget build(BuildContext context) {
    if (module.completion == true) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFF22A06B),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check_rounded,
          size: 18,
          color: Colors.white,
        ),
      );
    }
    if ((module.contentsCount ?? 0) > 1) {
      // Solid file icon, darker grey, with the count beside it.
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.description,
            size: 20,
            color: Color(0xFF3A3A3C),
          ),
          const SizedBox(width: 2),
          Text(
            '${module.contentsCount}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF3A3A3C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

/// Maps a `modname` to a coloured Material icon. The modname values
/// themselves come from the API — only the icon mapping is
/// client-side. When the modname is unknown we render a neutral
/// document icon so the UI never shows a blank slot.
class _ModnameIcon extends StatelessWidget {
  const _ModnameIcon({required this.modname});

  final String modname;

  static const _size = 32.0;

  static const Map<String, IconData> _glyphs = {
    'forum': Icons.forum_outlined,
    'assign': Icons.upload_file_outlined,
    'page': Icons.description_outlined,
    'resource': Icons.play_circle_outline,
    'folder': Icons.folder_outlined,
    'url': Icons.link_rounded,
    'quiz': Icons.help_outline,
    'label': Icons.label_outline,
    'lti': Icons.extension_outlined,
    'choice': Icons.poll_outlined,
    'feedback': Icons.feedback_outlined,
    'glossary': Icons.menu_book_outlined,
    'wiki': Icons.menu_book_outlined,
    'lesson': Icons.school_outlined,
    'scorm': Icons.play_lesson_outlined,
    'h5pactivity': Icons.quiz_outlined,
    'book': Icons.menu_book_outlined,
    'chat': Icons.chat_bubble_outline,
    'data': Icons.storage_outlined,
    'survey': Icons.assignment_outlined,
    'workshop': Icons.handshake_outlined,
  };

  static const Map<String, Color> _colors = {
    'forum': Color(0xFF6F4EE8),
    'assign': Color(0xFFE83E8C),
    'page': Color(0xFF11A89D),
    'resource': Color(0xFF11A89D),
    'folder': Color(0xFFE08C2E),
    'url': Color(0xFF1E88E5),
    'quiz': Color(0xFF22A06B),
    'label': Color(0xFF8E8E93),
    'lti': Color(0xFF6F4EE8),
    'choice': Color(0xFF22A06B),
    'feedback': Color(0xFFE08C2E),
    'glossary': Color(0xFF8E8E93),
    'wiki': Color(0xFF8E8E93),
    'lesson': Color(0xFF6F4EE8),
    'scorm': Color(0xFF1E88E5),
    'h5pactivity': Color(0xFFE83E8C),
    'book': Color(0xFF8E8E93),
    'chat': Color(0xFF6F4EE8),
    'data': Color(0xFF11A89D),
    'survey': Color(0xFFE83E8C),
    'workshop': Color(0xFF22A06B),
  };

  @override
  Widget build(BuildContext context) {
    final glyph = _glyphs[modname] ?? Icons.description_outlined;
    final color = _colors[modname] ?? const Color(0xFF8E8E93);
    return SizedBox(
      width: _size,
      height: _size,
      child: Icon(glyph, size: 26, color: color),
    );
  }
}

/// Renders a single API-supplied date string in a standard label /
/// value layout. Uses `intl.DateFormat` for locale-correct output
/// rather than a hand-rolled formatter.
class _DateLine extends StatelessWidget {
  const _DateLine({required this.label, required this.date});

  final String label;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatted = DateFormat('d MMM, y, h:mm a').format(date.toLocal());
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            TextSpan(
              text: formatted,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Outlined pill that displays verbatim content from the API — either
/// the module's `activityBadgeContent` or a file's `filename`.
class _FileChip extends StatelessWidget {
  const _FileChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF2A2A2E)
        : const Color(0xFFE5E7EB);
    final body = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
    if (onTap == null) return body;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: body,
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16.h),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
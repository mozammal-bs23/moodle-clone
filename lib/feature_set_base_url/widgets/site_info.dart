import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_constants.dart';

class SiteInfo extends StatefulWidget {
  const SiteInfo({super.key});

  @override
  State<SiteInfo> createState() => _SiteInfoState();
}

class _SiteInfoState extends State<SiteInfo> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.yourSite,
          style: TextStyle(
            fontSize: AppSize.fontXs,
            fontWeight: _isFocused ? FontWeight.w700 : FontWeight.w400,
            color: const Color(0xFFFF0000),
            letterSpacing: AppSize.letterSpacingNone,
            height: AppSize.lineHeight,
          ),
        ),
        const SizedBox(height: AppSpacing.mdSm),

        TextField(
          enableSuggestions: false,
          autocorrect: false,
          selectionControls: null,
          controller: _controller,
          focusNode: _focusNode,
          cursorColor: const Color(0xFFFF0000),
          style: const TextStyle(
            fontSize: AppSize.fontSm,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000),
            letterSpacing: AppSize.letterSpacingNone,
            height: AppSize.lineHeight,
          ),
          decoration: const InputDecoration(
            isDense: true,
            hintText: AppStrings.siteHint,
            hintStyle: TextStyle(
              fontSize: AppSize.fontSm,
              fontWeight: FontWeight.w400,
              color: Color(0xFF757575),
              letterSpacing: AppSize.letterSpacingNone,
              height: AppSize.lineHeight,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            filled: false,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
          ),
        ),

        const SizedBox(height: AppSpacing.mdLg),

        Divider(
          height: AppSize.lineHeight,
          thickness: AppSize.dividerThickness,
          color: const Color(0xFFE0E0E0),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your site',
            style: TextStyle(
              fontSize: 12,
              fontWeight: _isFocused ? FontWeight.w700 : FontWeight.w400,
              color: const Color(0xFFFF0000),
              letterSpacing: 0,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),

          TextField(
            enableSuggestions: false,
            autocorrect: false,
            selectionControls: null,
            controller: _controller,
            focusNode: _focusNode,
            cursorColor: const Color(0xFFFF0000),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
              letterSpacing: 0,
              height: 1,
            ),
            decoration: const InputDecoration(
              isDense: true,
              hintText: 'https://campus.example.edu',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF757575),
                letterSpacing: 0,
                height: 1,
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

          const SizedBox(height: 12),

          const Divider(height: 1, thickness: .8, color: Color(0xFFE0E0E0)),
        ],
      ),
    );
  }
}

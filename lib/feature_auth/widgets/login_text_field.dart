import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/password_visibility_toggle.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom text field widget tailored for the Moodle Login screen.
class LoginTextField extends StatefulWidget {
  /// Creates an instance of [LoginTextField].
  const LoginTextField({
    required this.controller,
    required this.label,
    this.isPassword = false,
    super.key,
  });

  /// The controller for the text being edited.
  final TextEditingController controller;

  /// The label text to display as a hint.
  final String label;

  /// Whether this field is for a password.
  final bool isPassword;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _isVisible = false;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.isPassword && !_isVisible,
      cursorColor: AppTheme.moodleOrange,
      style: TextStyle(
        fontSize: 16.sp,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: _isFocused ? null : widget.label,
        hintStyle: TextStyle(
          color: AppTheme.moodleLabelGrey,
          fontSize: 16.sp,
        ),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.moodleBorderGrey,
            width: 1.2.h,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.moodleOrange,
            width: 1.5.h,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
        suffixIcon: widget.isPassword
            ? PasswordVisibilityToggle(
                isVisible: _isVisible,
                onChanged: (v) => setState(() => _isVisible = v),
              )
            : null,
      ),
    );
  }
}

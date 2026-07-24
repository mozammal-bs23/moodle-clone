import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

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
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
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
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        // Background text disappears whenever the field is tapped (focused)
        hintText: _isFocused ? null : widget.label,
        hintStyle: const TextStyle(
          color: Color(0xFFADB5BD),
          fontSize: 16,
        ),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE9ECEF), width: 1.2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.moodleOrange, width: 1.5),
        ),
        // Ensures the hint text is vertically centered in the left middle
        contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        suffixIcon: widget.isPassword ? _buildVisibilityToggle() : null,
      ),
    );
  }

  Widget _buildVisibilityToggle() {
    return IconButton(
      icon: Icon(
        _isVisible ? Icons.visibility_outlined : Icons.visibility_sharp,
        color: Colors.black,
        size: 20,
      ),
      onPressed: () => setState(() => _isVisible = !_isVisible),
    );
  }
}

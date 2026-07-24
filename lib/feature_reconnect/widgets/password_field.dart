import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      cursorColor: const Color(0xFFF9A865),
      onChanged: widget.onChanged,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF212121),
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: false,
        border: InputBorder.none,

        hintText: 'Password',
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF212121),
        ),

        contentPadding: const EdgeInsets.only(
          top: 8,
          bottom: 4,
        ),

        suffixIconConstraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
        ),

        suffixIcon: IconButton(
          splashRadius: 18,
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText
                ? Icons.remove_red_eye
                : Icons.visibility_off,
            size: 24,
            color: const Color(0xFF2F2F2F),
          ),
        ),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD0D0D0), // Ash grey
            width: 0.7,
          ),
        ),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF9E9E9E), // Dark ash
            width: 1.1,
          ),
        ),
      ),
    );
  }
}
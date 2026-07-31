import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Eye icon that flips [isVisible] when tapped, used as the suffix icon
/// for password fields in the login screen.
class PasswordVisibilityToggle extends StatelessWidget {
  /// Creates a [PasswordVisibilityToggle].
  const PasswordVisibilityToggle({
    required this.isVisible,
    required this.onChanged,
    super.key,
  });

  /// Whether the password is currently shown in plain text.
  final bool isVisible;

  /// Called when the user taps the icon. Receives the new visibility state.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_sharp,
        color: Theme.of(context).colorScheme.onSurface,
        size: 20.r,
      ),
      onPressed: () => onChanged(!isVisible),
    );
  }
}

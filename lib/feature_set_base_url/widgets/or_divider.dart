import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        AppStrings.or,
        style: TextStyle(
          fontSize: AppSize.fontMd,
          fontWeight: FontWeight.w400,
          color: Color(0xFF212121),
          letterSpacing: AppSize.letterSpacingNone,
          height: AppSize.lineHeight,
        ),
      ),
    );
  }
}

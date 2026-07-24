import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_constants.dart';

class BaseUrlHeader extends StatelessWidget {
  const BaseUrlHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.headerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            AppStrings.connectToMoodle,
            style: TextStyle(
              fontSize: AppSize.fontLg,
              fontWeight: FontWeight.w500,
              color: Color(0xFF212121),
              letterSpacing: AppSize.letterSpacingTight,
              height: AppSize.lineHeight,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            splashRadius: AppSize.splashRadius,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: AppSize.iconButtonMinSize,
              minHeight: AppSize.iconButtonMinSize,
            ),
            icon: const Icon(
              Icons.settings,
              size: AppSize.iconSettings,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_assets.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_constants.dart';

class MoodleLogo extends StatelessWidget {
  const MoodleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSize.logoWidth,
        height: AppSize.logoHeight,
        child: Image.asset(
          AppAssets.moodleLogo,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

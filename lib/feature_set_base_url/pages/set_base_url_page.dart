import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/base_url_header.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/help_link.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/moodle_logo.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/or_divider.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/qr_scan_button.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/site_info.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_constants.dart';

class SetBaseUrlPage extends StatelessWidget {
  const SetBaseUrlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppSpacing.xxs),

              BaseUrlHeader(),

              SizedBox(height: AppSpacing.xlMd),

              MoodleLogo(),

              SizedBox(height: AppSpacing.xxlSm),

              SiteInfo(),

              SizedBox(height: AppSpacing.xlMd),

              OrDivider(),

              SizedBox(height: AppSpacing.xlMd),

              QrScanButton(),

              SizedBox(height: AppSpacing.xlSm),

              HelpLink(),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

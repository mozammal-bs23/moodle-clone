import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/base_url_header.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/help_link.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/moodle_logo.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/or_divider.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/qr_scan_button.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/site_info.dart';

class SetBaseUrlPage extends StatelessWidget {
  const SetBaseUrlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5),

              BaseUrlHeader(),

              SizedBox(height: 34),

              MoodleLogo(),

              SizedBox(height: 44),

              SiteInfo(),

              SizedBox(height: 34),

              OrDivider(),

              SizedBox(height: 34),

              QrScanButton(),

              SizedBox(height: 22),

              HelpLink(),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

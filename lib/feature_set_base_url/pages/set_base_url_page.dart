import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_qr_scan/pages/qr_scan_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/base_url_header.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/help_link.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/moodle_logo.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/or_divider.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/qr_scan_button.dart';
import 'package:flutter_boilerplate/feature_set_base_url/widgets/site_info.dart';
import 'package:flutter_boilerplate_core/utils/constants/app_constants.dart';

class SetBaseUrlPage extends StatefulWidget {
  const SetBaseUrlPage({super.key});

  @override
  State<SetBaseUrlPage> createState() => _SetBaseUrlPageState();
}

class _SetBaseUrlPageState extends State<SetBaseUrlPage> {
  final TextEditingController _siteController = TextEditingController();

  @override
  void dispose() {
    _siteController.dispose();
    super.dispose();
  }

  /// Push the QR scanner; if it returns a non-null URL, fill the text
  /// field and request focus so the user can keep editing / submit.
  Future<void> _openQrScanner() async {
    final scanned = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const QrScanPage(),
        fullscreenDialog: true,
      ),
    );
    if (scanned == null || scanned.isEmpty) return;
    if (!mounted) return;
    setState(() {
      _siteController.text = scanned;
      _siteController.selection = TextSelection.collapsed(
        offset: scanned.length,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxs),

              const BaseUrlHeader(),

              const SizedBox(height: AppSpacing.xlMd),

              const MoodleLogo(),

              const SizedBox(height: AppSpacing.xxlSm),

              SiteInfo(controller: _siteController),

              const SizedBox(height: AppSpacing.xlMd),

              const OrDivider(),

              const SizedBox(height: AppSpacing.xlMd),

              QrScanButton(onPressed: _openQrScanner),

              const SizedBox(height: AppSpacing.xlSm),

              const HelpLink(),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
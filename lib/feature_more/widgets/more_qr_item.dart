import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the Scan QR Code feature.
class MoreQrItem extends StatelessWidget {
  /// Creates an instance of [MoreQrItem].
  const MoreQrItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.qr_code,
      label: AppStrings.labelScanQrCode,
      onTap: () {
        // Will navigate to detailed Scan QR Code page later
      },
    );
  }
}

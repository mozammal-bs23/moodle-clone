import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_boilerplate/feature_qr_scan/cubit/qr_scan_cubit.dart';
import 'package:flutter_boilerplate/feature_qr_scan/cubit/qr_scan_state.dart';
import 'package:flutter_boilerplate/feature_qr_scan/utils/qr_strings.dart';

/// Bottom row of controls rendered over the camera viewfinder: the
/// camera-switch (left) and torch toggle (right).
///
/// Reads state directly from [QrScanCubit] so the icons stay in sync with
/// the underlying camera controller. The icons deliberately inherit the
/// app-bar's X color so the bottom controls feel like part of the same
/// chrome bar.
class ScannerControls extends StatelessWidget {
  const ScannerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrScanCubit, QrScanState>(
      buildWhen: (prev, next) =>
          prev.torchEnabled != next.torchEnabled ||
          prev.usingFrontCamera != next.usingFrontCamera,
      builder: (context, state) {
        final cubit = context.read<QrScanCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                tooltip: QrStrings.switchCameraTooltip,
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  unawaited(cubit.switchCamera());
                  HapticFeedback.selectionClick();
                },
                icon: const Icon(Icons.cameraswitch_outlined),
              ),
              IconButton(
                tooltip: state.torchEnabled
                    ? QrStrings.torchOnTooltip
                    : QrStrings.torchOffTooltip,
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  unawaited(cubit.toggleTorch());
                  HapticFeedback.selectionClick();
                },
                icon: Icon(
                  state.torchEnabled
                      ? Icons.flash_on
                      : Icons.flash_off_outlined,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
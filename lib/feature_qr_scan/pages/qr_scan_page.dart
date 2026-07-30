import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_boilerplate/feature_qr_scan/cubit/qr_scan_cubit.dart';
import 'package:flutter_boilerplate/feature_qr_scan/cubit/qr_scan_state.dart';
import 'package:flutter_boilerplate/feature_qr_scan/utils/qr_strings.dart';
import 'package:flutter_boilerplate/feature_qr_scan/widgets/scan_result_overlay.dart';
import 'package:flutter_boilerplate/feature_qr_scan/widgets/scanner_app_bar.dart';
import 'package:flutter_boilerplate/feature_qr_scan/widgets/scanner_controls.dart';
import 'package:flutter_boilerplate/feature_qr_scan/widgets/scanner_overlay.dart';
import 'package:flutter_boilerplate/feature_qr_scan/widgets/scanner_viewfinder.dart';

/// Full-screen QR scanner.
///
/// Pushed onto the navigator by [SetBaseUrlPage] via
/// `Navigator.push<String>`. Pops back with a parsed base URL when the
/// user accepts a scan, or with `null` if they cancel.
class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QrScanCubit>(
      create: (_) => QrScanCubit()..initialize(),
      child: const _QrScanView(),
    );
  }
}

class _QrScanView extends StatelessWidget {
  const _QrScanView();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: false,
        appBar: ScannerAppBar(onClose: () => Navigator.of(context).pop()),
        body: BlocConsumer<QrScanCubit, QrScanState>(
          listenWhen: (prev, next) =>
              prev.errorMessage != next.errorMessage && next.errorMessage != null,
          listener: (context, state) {
            if (state.errorMessage == 'invalid') {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Text(
                      QrStrings.invalidQrBody,
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              // Allow scanning again after the user sees the message.
              context.read<QrScanCubit>().resumeScanning();
            }
          },
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // Layered status body (scanner / loading / permission / error).
                switch (state.status) {
                  QrScanStatus.initial => const _LoadingView(),
                  QrScanStatus.permissionDenied =>
                    const _PermissionDeniedView(),
                  QrScanStatus.cameraError => const _CameraErrorView(),
                  QrScanStatus.scanning ||
                  QrScanStatus.detected =>
                    _ScannerBody(state: state),
                },
                // Result overlay pinned on top whenever we have a parsed URL.
                if (state.parsedUrl != null)
                  ScanResultOverlay(
                    parsedUrl: state.parsedUrl!,
                    rawValue: state.lastRawValue ?? state.parsedUrl!,
                    onUse: () {
                      final parsed = state.parsedUrl!;
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).pop(parsed);
                    },
                    onScanAgain: () {
                      context.read<QrScanCubit>().resumeScanning();
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ScannerBody extends StatelessWidget {
  const _ScannerBody({required this.state});

  final QrScanState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QrScanCubit>();
    return Stack(
      fit: StackFit.expand,
      children: [
        ScannerViewfinder(
          controller: cubit.cameraController,
          onDetect: (capture) {
            final parsed = cubit.onDetect(capture);
            if (parsed != null) {
              HapticFeedback.mediumImpact();
              // Don't pop yet — let the user choose between Copy and Use
              // from the result overlay. Popping happens in onUse.
            }
          },
          overlay: const ScannerOverlay(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: const SafeArea(
            top: false,
            child: ScannerControls(),
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

class _PermissionDeniedView extends StatelessWidget {
  const _PermissionDeniedView();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.no_photography_outlined,
                  size: 56, color: Colors.black54),
              const SizedBox(height: 16),
              Text(
                QrStrings.permissionTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                QrStrings.permissionBody,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                ),
                onPressed: () async {
                  await openAppSettings();
                },
                child: const Text(QrStrings.permissionOpenSettings),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    context.read<QrScanCubit>().initialize(),
                child: const Text(QrStrings.permissionRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraErrorView extends StatelessWidget {
  const _CameraErrorView();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  size: 56, color: Colors.black54),
              const SizedBox(height: 16),
              Text(
                QrStrings.cameraErrorTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                QrStrings.cameraErrorBody,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                ),
                onPressed: () =>
                    context.read<QrScanCubit>().initialize(),
                child: const Text(QrStrings.cameraRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
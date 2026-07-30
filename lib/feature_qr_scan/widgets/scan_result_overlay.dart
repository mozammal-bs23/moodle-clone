import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_boilerplate/feature_qr_scan/utils/qr_strings.dart';

/// Slide-up overlay shown after a successful scan.
///
/// Painted on top of the camera viewfinder (which is paused while this
/// is visible). Renders the parsed URL prominently with the raw code
/// underneath, plus Copy / Use / Scan-again actions.
///
/// The overlay intentionally intercepts taps so the user cannot accidentally
/// scan another code while looking at the result.
class ScanResultOverlay extends StatelessWidget {
  const ScanResultOverlay({
    required this.parsedUrl,
    required this.rawValue,
    required this.onUse,
    required this.onScanAgain,
    super.key,
  });

  /// The normalized base URL extracted from the scan.
  final String parsedUrl;

  /// The original raw text the camera read, shown for context.
  final String rawValue;

  /// Called when the user taps "Use this URL". The page pops the route.
  final VoidCallback onUse;

  /// Called when the user taps "Scan again". The page dismisses the
  /// overlay and resumes scanning.
  final VoidCallback onScanAgain;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle + title row.
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          QrStrings.resultTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: onScanAgain,
                        child: const Text(QrStrings.resultScanAgain),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Parsed URL card.
                  _ResultField(
                    label: QrStrings.resultParsedLabel,
                    value: parsedUrl,
                    isPrimary: true,
                  ),
                  const SizedBox(height: 12),
                  // Raw code card (only shown if it differs from the parsed URL).
                  if (rawValue != parsedUrl)
                    _ResultField(
                      label: QrStrings.resultRawLabel,
                      value: rawValue,
                      isPrimary: false,
                    ),
                  const SizedBox(height: 20),
                  // Action buttons.
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: parsedUrl),
                            );
                            if (!context.mounted) return;
                            HapticFeedback.selectionClick();
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text(QrStrings.copied),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                          },
                          icon: const Icon(Icons.copy_outlined, size: 18),
                          label: const Text(QrStrings.resultCopy),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF111111),
                            side: const BorderSide(color: Color(0xFF1E1E1E)),
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: onUse,
                          icon: const Icon(Icons.check, size: 18),
                          label: const Text(QrStrings.resultUse),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF1E1E1E),
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultField extends StatelessWidget {
  const _ResultField({
    required this.label,
    required this.value,
    required this.isPrimary,
  });

  final String label;
  final String value;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFF6F7F8) : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
              color: Color(0xFF6B6B6B),
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            value,
            style: TextStyle(
              fontSize: isPrimary ? 16 : 13,
              fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w400,
              color: const Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}
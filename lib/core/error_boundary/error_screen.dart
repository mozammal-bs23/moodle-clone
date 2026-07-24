import 'package:flutter/material.dart';

/// Screen displayed when an unhandled error occurs
class ErrorScreen extends StatelessWidget {
  /// Creates an error screen
  const ErrorScreen({
    required this.error,
    this.stackTrace,
    this.onRetry,
    super.key,
  });

  /// Error message
  final String error;

  /// Stack trace (optional)
  final String? stackTrace;

  /// Callback to retry
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xFFB71C1C);
    const bgColor = Color(0xFFFFEBEE);

    return MaterialApp(
      home: Material(
        color: bgColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: redColor,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Oops! Something went wrong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7F0000),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'An unexpected error occurred during startup.',
                  style: TextStyle(
                    fontSize: 14,
                    color: redColor,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFCDD2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Error Details:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        error,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

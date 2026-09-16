import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.error, this.stackTrace, this.onRetry});

  final Object? error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;

  String get _errorMessage {
    if (error case final Failure f) {
      if (kDebugMode && f.exception != null) {
        return '${f.message}\n\nTechnical Details: ${f.exception}';
      }
      return f.message;
    }
    return kDebugMode ? error.toString() : 'An unexpected error occurred. Please try again later.';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(_errorMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ),
          if (stackTrace != null && kDebugMode) ...[
            const SizedBox(height: 8),
            Text(
              'Stack trace:\n$stackTrace',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

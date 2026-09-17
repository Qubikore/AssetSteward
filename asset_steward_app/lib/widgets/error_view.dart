import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.error, this.stackTrace, this.onRetry, this.compact = false});

  final Object? error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;
  final bool compact;

  String get _userMessage {
    if (error is Failure) {
      return (error as Failure).message;
    }
    return 'An unexpected error occurred. Please try again later.';
  }

  String? get _technicalDetails {
    if (error is Failure) {
      final f = error as Failure;
      if (f.exception != null) {
        final exStr = f.exception.toString();
        // Avoid duplicate message if the exception string just repeats the failure message
        if (exStr.contains(f.message)) {
          return exStr;
        }
        return '${f.message}\n$exStr';
      }
    }
    return error?.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(HIStroke.alert01, color: context.colors.error, size: 28),
            const Gap(Insets.sm),
            Text(
              _userMessage,
              style: context.text.bodyMedium?.copyWith(color: context.colors.error),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (onRetry != null) ...[
              const Gap(Insets.sm),
              FilledButton.tonal(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(Insets.xl),
              decoration: BoxDecoration(
                color: context.colors.errorContainer.op(0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: context.colors.error.op(0.3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Insets.lg),
                    decoration: BoxDecoration(color: context.colors.errorContainer, shape: BoxShape.circle),
                    child: Icon(HIStroke.alert01, size: 48, color: context.colors.error),
                  ),
                  const Gap(Insets.xl),
                  Text(
                    'Oops! Something went wrong',
                    style: context.text.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onErrorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.md),
                  Text(
                    _userMessage,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.bodyLarge?.copyWith(color: context.colors.onErrorContainer.op(0.8)),
                  ),
                  const Gap(Insets.xl),
                  if (onRetry != null)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(HIStroke.refresh),
                        label: const Text('Try Again'),
                        style: FilledButton.styleFrom(
                          backgroundColor: context.colors.error,
                          foregroundColor: context.colors.onError,
                        ),
                      ),
                    ),
                  if (kDebugMode) ...[
                    const Gap(Insets.xs),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Chirp.error(_technicalDetails ?? _userMessage, error: error, stackTrace: stackTrace);
                        },
                        icon: const Icon(HIStroke.bug02),
                        label: const Text('Log Error'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colors.error,
                          side: BorderSide(color: context.colors.error.op(0.5)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

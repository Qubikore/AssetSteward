import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class QRScanResultPage extends HookConsumerWidget {
  const QRScanResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetId = int.tryParse(context.queryParams['res'] ?? '');

    final assetAsync = ref.watch(assetDetailsCtrlProvider(assetId ?? -1));

    useValueChanged(assetAsync, (_, _) async {
      if (assetAsync.hasValue && assetAsync.value != null && !assetAsync.hasError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.pushReplacement(RPaths.assetDetails(assetId.toString()).path, extra: assetAsync.value);
        });
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Processing Scan')),
      body: Center(
        child: assetAsync.when(
          loading: () => const Column(
            mainAxisSize: MainAxisSize.min,
            children: [Loader(), Gap(Insets.md), Text('Fetching asset details...')],
          ),
          error: (err, stack) => Padding(
            padding: const EdgeInsets.all(Insets.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(HIStroke.alert01, size: 48, color: Colors.red),
                const Gap(Insets.lg),
                Text('Invalid QR Code', style: context.text.titleLarge?.bold),
                const Gap(Insets.md),
                Text(
                  'The scanned QR code does not match any valid asset in the system.',
                  textAlign: TextAlign.center,
                  style: context.text.bodyMedium?.textColor(context.colors.outline),
                ),
                const Gap(Insets.xl),
                FilledButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(HIStroke.scan),
                  label: const Text('Scan Again'),
                ),
              ],
            ),
          ),
          data: (data) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

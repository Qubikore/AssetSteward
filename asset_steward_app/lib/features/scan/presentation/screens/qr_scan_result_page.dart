import 'dart:convert';

import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class QRScanResultPage extends HookConsumerWidget {
  const QRScanResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = context.queryParams['res'];

    final info = useMemoized(() {
      Chirp.info('QR', data: {'res': res});
      if (res == null) return null;
      try {
        final map = jsonDecode(res);
        if (map case {'id': final int id, 'name': final String name, 'assetCode': final String assetCode}) {
          return (id: id, name: name, code: assetCode);
        }
      } catch (_) {}
      return null;
    }, [res]);

    final assetAsync = info != null ? ref.watch(assetDetailsCtrlProvider(info.id)) : null;

    final isNavigating = useState(false);

    if (info != null) {
      ref.listen(
        assetDetailsCtrlProvider(info.id),
        (prev, next) {
          if (next case AsyncData(:final AssetModel value) when !isNavigating.value) {
            isNavigating.value = true;
            context.pushReplacement(RPaths.assetDetails(value.id.toString()).path);
          }
        },
      );
    }

    useEffect(() {
      if (assetAsync case AsyncData(:final AssetModel value) when !isNavigating.value) {
        isNavigating.value = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.pushReplacement(RPaths.assetDetails(value.id.toString()).path);
          }
        });
      }
      return null;
    }, const []);

    final errorView = Padding(
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
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Processing Scan')),
      body: Center(
        child:
            assetAsync?.when(
              loading: () => const Column(
                mainAxisSize: MainAxisSize.min,
                children: [Loader(), Gap(Insets.md), Text('Fetching asset details...')],
              ),
              error: (err, stack) => errorView,
              data: (data) => const SizedBox.shrink(),
            ) ??
            errorView,
      ),
    );
  }
}

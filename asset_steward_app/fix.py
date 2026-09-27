
import sys
path = r'E:\Developments\FlutterProject\AssetSteward\asset_steward_app\lib\features\assets\presentation\screens\asset_details_page.dart'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

import re

# 1. Context menu addition
new_menu_item = '''                ContextMenuAction(
                  label: 'Update Quantity',
                  icon: HIStroke.add01,
                  onPressed: () async {
                    if (assetAsync.value == null) return;
                    final qty = await showDialog<int>(
                      context: context,
                      builder: (_) => _UpdateQuantityDialog(initialQuantity: assetAsync.value!.quantity),
                    );
                    if (qty != null && context.mounted) {
                      final success = await ref.read(assetsCtrlProvider.notifier).updateAsset(
                            id,
                            {'quantity': qty},
                          );
                      if (success) {
                        ref.invalidate(assetDetailsCtrlProvider(id));
                      }
                    }
                  },
                ),
                ContextMenuAction('''

content = content.replace('ContextMenuAction(', new_menu_item, 1)

# 2. Header icon removal
header_pattern = r'Container\(\s*padding: const EdgeInsets\.all\(24\),\s*decoration: BoxDecoration\(color: context\.colors\.primaryContainer, shape: BoxShape\.circle\),\s*child: Icon\(HIStroke\.laptopProgramming, size: 48, color: context\.colors\.primary\),\s*\),\s*const Gap\(Insets\.lg\),'
content = re.sub(header_pattern, '', content)

# 3. Details Row usages update
content = content.replace('_DetailRow(label: \'Serial Number\', value: asset.serialNumber ?? \'N/A\')', '_DetailRow(label: \'Serial Number\', value: asset.serialNumber)')
content = content.replace('_DetailRow(label: \'Category\', value: asset.category?.name ?? \'Uncategorized\')', '_DetailRow(label: \'Category\', value: asset.category?.name)')
content = content.replace('_DetailRow(label: \'Location\', value: asset.location?.name ?? \'Unassigned\')', '_DetailRow(label: \'Location\', value: asset.location?.name)')
content = content.replace('_DetailRow(label: \'Department\', value: asset.department?.name ?? \'Unassigned\')', '_DetailRow(label: \'Department\', value: asset.department?.name)')
content = content.replace('_DetailRow(label: \'Vendor\', value: asset.vendor ?? \'N/A\')', '_DetailRow(label: \'Vendor\', value: asset.vendor)')
content = content.replace('_DetailRow(label: \'Expire Date\', value: asset.expireDate ?? \'N/A\')', '_DetailRow(label: \'Expire Date\', value: asset.expireDate)')

# Add Quantity row
content = content.replace('_DetailRow(label: \'Purchase Price\'', '_DetailRow(label: \'Quantity\', value: asset.quantity.toString()),\n                        _DetailRow(label: \'Purchase Price\'')

# 4. Update _DetailRow definition
old_detail_row = '''class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: context.text.bodyMedium?.bold, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}'''

new_detail_row = '''class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty && value != 'N/A' && value != 'Uncategorized' && value != 'Unassigned';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              hasValue ? value! : '--',
              style: context.text.bodyMedium?.copyWith(
                fontWeight: hasValue ? FontWeight.bold : FontWeight.normal,
                color: hasValue ? context.colors.onSurface : context.colors.outline,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateQuantityDialog extends HookWidget {
  final int initialQuantity;

  const _UpdateQuantityDialog({required this.initialQuantity});

  @override
  Widget build(BuildContext context) {
    final qtyState = useState(initialQuantity);
    final ctrl = useTextEditingController(text: initialQuantity.toString());

    return AlertDialog(
      title: const Text('Update Quantity'),
      content: Row(
        children: [
          IconButton.filledTonal(
            onPressed: () {
              if (qtyState.value > 0) {
                qtyState.value--;
                ctrl.text = qtyState.value.toString();
              }
            },
            icon: const Icon(HIStroke.minusSign),
          ),
          const Gap(Insets.md),
          Expanded(
            child: TextFormField(
              controller: ctrl,
              autofocus: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (v) => qtyState.value = int.tryParse(v) ?? 0,
            ),
          ),
          const Gap(Insets.md),
          IconButton.filledTonal(
            onPressed: () {
              qtyState.value++;
              ctrl.text = qtyState.value.toString();
            },
            icon: const Icon(HIStroke.add01),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => context.pop(qtyState.value),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
'''

content = content.replace(old_detail_row, new_detail_row)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Done!')


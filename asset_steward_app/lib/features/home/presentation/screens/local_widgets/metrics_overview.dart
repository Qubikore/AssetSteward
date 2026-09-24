import 'package:asset_steward_app/features/home/data/models/dashboard_metrics.dart';
import 'package:asset_steward_app/features/home/presentation/screens/local_widgets/metric_card.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class MetricsOverview extends StatelessWidget {
  final DashboardMetrics metrics;

  const MetricsOverview({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(Insets.xl),
          decoration: BoxDecoration(color: context.colors.primaryContainer, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(HIStroke.money01, color: context.colors.onPrimaryContainer, size: 28),
                  const Gap(Insets.sm),
                  Text(
                    'Total Asset Value',
                    style: context.text.titleMedium?.medium.textColor(context.colors.onPrimaryContainer.op(0.8)),
                  ),
                ],
              ),
              const Gap(Insets.sm),
              Text(
                '\$${metrics.totalAssetValue.toStringAsFixed(2)}',
                style: context.text.displaySmall?.bold.textColor(context.colors.onPrimaryContainer),
              ),
            ],
          ),
        ),
        const Gap(Insets.lg),
        Row(
          children: [
            Expanded(
              child: MetricCard(title: 'Total Assets', value: metrics.totalAssets, icon: HIStroke.deliveryBox01),
            ),
            const Gap(Insets.md),
            Expanded(
              child: MetricCard(title: 'Available', value: metrics.availableAssets, icon: HIStroke.checkmarkBadge01),
            ),
          ],
        ),
        const Gap(Insets.md),
        Row(
          children: [
            Expanded(
              child: MetricCard(title: 'Assigned', value: metrics.assignedAssets, icon: HIStroke.userAdd01),
            ),
            const Gap(Insets.md),
            Expanded(
              child: MetricCard(title: 'Maintenance', value: metrics.maintenanceAssets, icon: HIStroke.settings01),
            ),
          ],
        ),
      ],
    );
  }
}

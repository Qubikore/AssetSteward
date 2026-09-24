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
        MetricCard(
          title: 'Total Asset Value',
          value: '\$${metrics.totalAssetValue.toStringAsFixed(2)}',
          icon: HIStroke.money01,
        ),
        const Gap(Insets.sm),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Total Assets',
                value: metrics.totalAssets.toString(),
                icon: HIStroke.deliveryBox01,
              ),
            ),
            const Gap(Insets.sm),
            Expanded(
              child: MetricCard(
                title: 'Available',
                value: metrics.availableAssets.toString(),
                icon: HIStroke.checkmarkBadge01,
              ),
            ),
          ],
        ),
        const Gap(Insets.sm),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Assigned',
                value: metrics.assignedAssets.toString(),
                icon: HIStroke.userAdd01,
              ),
            ),
            const Gap(Insets.sm),
            Expanded(
              child: MetricCard(
                title: 'Maintenance',
                value: metrics.maintenanceAssets.toString(),
                icon: HIStroke.settings01,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

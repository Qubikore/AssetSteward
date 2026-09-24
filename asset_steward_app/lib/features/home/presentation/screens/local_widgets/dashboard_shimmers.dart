import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer/shimmer.dart';

class DashboardMetricsShimmer extends StatelessWidget {
  const DashboardMetricsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surfaceContainerHighest.op(0.4),
      highlightColor: context.colors.surfaceContainerHighest.op(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ShimmerBox(height: 72, width: double.infinity),
          const Gap(Insets.sm),
          Row(
            children: [
              const Expanded(child: _ShimmerBox(height: 72)),
              const Gap(Insets.sm),
              const Expanded(child: _ShimmerBox(height: 72)),
            ],
          ),
          const Gap(Insets.sm),
          Row(
            children: [
              const Expanded(child: _ShimmerBox(height: 72)),
              const Gap(Insets.sm),
              const Expanded(child: _ShimmerBox(height: 72)),
            ],
          ),
        ],
      ),
    );
  }
}

class UtilizationShimmer extends StatelessWidget {
  const UtilizationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surfaceContainerHighest.op(0.4),
      highlightColor: context.colors.surfaceContainerHighest.op(0.1),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, __) => const Gap(Insets.sm),
        itemBuilder: (_, __) => const _ShimmerBox(height: 72, width: double.infinity),
      ),
    );
  }
}

class MiniListShimmer extends StatelessWidget {
  const MiniListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surfaceContainerHighest.op(0.4),
      highlightColor: context.colors.surfaceContainerHighest.op(0.1),
      child: Column(
        children: [
          const _ShimmerBox(height: 64, width: double.infinity),
          const Gap(Insets.sm),
          const _ShimmerBox(height: 64, width: double.infinity),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  final double? width;

  const _ShimmerBox({required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

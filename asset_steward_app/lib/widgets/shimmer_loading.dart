import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final int count;
  final double itemHeight;
  final double separatorHeight;

  const ShimmerList({
    super.key,
    this.count = 5,
    this.itemHeight = 72.0,
    this.separatorHeight = Insets.sm,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surfaceContainerHighest.op(0.4),
      highlightColor: context.colors.surfaceContainerHighest.op(0.1),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        separatorBuilder: (_, _) => Gap(separatorHeight),
        itemBuilder: (_, _) => Container(
          height: itemHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

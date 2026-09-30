import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer/shimmer.dart';

import 'section_title.dart';

class ProfilePageShimmer extends StatelessWidget {
  const ProfilePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.lg,
        vertical: Insets.md,
      ).copyWith(top: 6).withBottomEx(),
      children: [
        Shimmer.fromColors(
          baseColor: context.colors.surfaceContainerHighest.op(0.4),
          highlightColor: context.colors.surfaceContainerHighest.op(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.outlineVariant.op(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(Insets.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 150, height: 16, color: Colors.white),
                          const Gap(Insets.xs),
                          Container(width: 200, height: 12, color: Colors.white),
                          const Gap(Insets.xs),
                          Container(width: 100, height: 12, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.sm),
                const Divider(height: 0),
                const Gap(Insets.sm),
                Container(width: 120, height: 16, color: Colors.white),
                const Gap(Insets.xs),
                Container(width: 180, height: 12, color: Colors.white),
              ],
            ),
          ),
        ),
        
        const Gap(Insets.lg),
        const SectionTitle(title: 'Settings'),
        const Gap(Insets.xs),
        
        Shimmer.fromColors(
          baseColor: context.colors.surfaceContainerHighest.op(0.4),
          highlightColor: context.colors.surfaceContainerHighest.op(0.1),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Container(width: 24, height: 24, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                      const Gap(16),
                      Container(width: 120, height: 16, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

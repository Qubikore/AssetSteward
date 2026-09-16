import 'package:material_ui/material_ui.dart';

class UniversalHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  /// Optional builder if you want dynamic behavior based on shrinkOffset
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent)? builder;

  UniversalHeaderDelegate({required this.minHeight, required this.maxHeight, required this.child, this.builder});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder?.call(context, shrinkOffset, overlapsContent) ?? child;
  }

  @override
  bool shouldRebuild(UniversalHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

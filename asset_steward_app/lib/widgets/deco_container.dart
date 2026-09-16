import 'package:material_ui/material_ui.dart';

class DecoContainer extends StatelessWidget {
  const DecoContainer({
    super.key,
    this.color,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.borderRadiusGeo,
    this.width,
    this.height,
    this.child,
    this.ignorePointer = false,
    this.shadows,
    this.clipChild = false,
    this.padding,
    this.alignment,
    this.margin,
    this.gradient,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.constraints,
    this.shape,
    this.useSuperellipse = false,
  }) : duration = const Duration(),
       curve = Curves.linear;

  const DecoContainer.animated({
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.linear,
    super.key,
    this.color,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.borderRadiusGeo,
    this.width,
    this.height,
    this.child,
    this.ignorePointer = false,
    this.shadows,
    this.clipChild = false,
    this.padding,
    this.alignment,
    this.margin,
    this.gradient,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.constraints,
    this.shape,
    this.useSuperellipse = false,
  });

  final Alignment? alignment;
  final Color? borderColor;
  final double borderRadius;
  final BorderRadiusGeometry? borderRadiusGeo;
  final double borderWidth;
  final Widget? child;
  final bool clipChild;
  final Color? color;
  final Duration duration;
  final double? height;
  final bool ignorePointer;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadows;
  final double? width;
  final Curve curve;
  final Gradient? gradient;
  final double strokeAlign;
  final BoxConstraints? constraints;
  final BoxShape? shape;
  final bool useSuperellipse;

  @override
  Widget build(BuildContext context) {
    // Create border if we have both a color and width
    BoxBorder? border;
    if (borderColor != null && borderWidth != 0) {
      border = Border.all(color: borderColor!, width: borderWidth, strokeAlign: strokeAlign);
    }

    BorderRadiusGeometry effectiveBorderRadius = BorderRadius.circular(borderRadius);

    if (borderRadiusGeo != null) effectiveBorderRadius = borderRadiusGeo!;

    final useShapeDecoration =
        (useSuperellipse || (borderRadius >= 12 && borderRadius < 100)) && shape != BoxShape.circle && gradient == null;

    final shapeBorder = ContinuousRectangleBorder(
      borderRadius: effectiveBorderRadius,
      side: borderColor != null && borderWidth != 0
          ? BorderSide(color: borderColor!, width: borderWidth, strokeAlign: strokeAlign)
          : BorderSide.none,
    );

    final dec = useShapeDecoration
        ? ShapeDecoration(color: color, shadows: shadows, shape: shapeBorder)
        : BoxDecoration(
            color: color,
            border: border,
            borderRadius: shape == BoxShape.circle ? null : effectiveBorderRadius,
            boxShadow: shadows,
            gradient: gradient,
            shape: shape ?? BoxShape.rectangle,
          );

    final childWidget = clipChild && useShapeDecoration
        ? ClipPath(
            clipper: ShapeBorderClipper(shape: shapeBorder),
            child: child,
          )
        : clipChild
        ? ClipRRect(borderRadius: effectiveBorderRadius as BorderRadius, child: child)
        : child;

    return IgnorePointer(
      ignoring: ignorePointer,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        decoration: dec,
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        alignment: alignment,
        constraints: constraints,
        child: childWidget,
      ),
    );
  }
}

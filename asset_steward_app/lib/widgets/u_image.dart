import 'dart:io';

import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:universal_image/universal_image.dart';

class UImage extends StatelessWidget {
  const UImage(
    this.src, {
    super.key,
    this.height,
    this.width,
    this.dimension,
    this.fit = BoxFit.cover,
    this.onImgTap,
    this.borderRadius,
    this.isAvatar = false,
    this.iconSize,
    this.color,
    this.colorBlendMode,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
  });

  /// Image source, it can be
  /// - `http url`,
  /// - `assets file path` (assets path must start with `assets`),
  /// - `local file path`
  /// - `icon data`
  /// - `Base64 string`
  /// - `Uint8List`
  final Object src;

  final double? height;
  final double? width;

  /// if not null then height and width are ignored
  final double? dimension;
  final double? iconSize;
  final BoxFit fit;
  final void Function()? onImgTap;
  final bool isAvatar;
  final double? borderRadius;

  /// An optional `Color` property that sets the color of the image.
  final Color? color;

  /// An optional `BlendMode` property that defines how the image color should blend with the background.
  final BlendMode? colorBlendMode;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius != null ? BorderRadius.circular(borderRadius!) : BorderRadius.zero;
    final hasRadius = borderRadius != null && borderRadius! > 0;

    final double? h = dimension ?? height;
    final double? w = dimension ?? width;
    final size = iconSize ?? 24;

    dynamic source = src;
    if (src case final File file) source = file.path;

    final image = UniversalImage(
      source,
      width: w,
      height: h,
      size: size,
      fit: fit,
      color: color,
      placeholder: const Loader(size: 20, strokeWidth: 2),
      errorPlaceholder: Center(
        child: Icon(
          isAvatar ? HIStroke.user : HIStroke.image01,
          color: isAvatar ? context.colors.primary : context.colors.onSurfaceVariant,
          size: size,
        ),
      ),
    );

    final container = Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: backgroundColor,
        border: (borderColor != null || borderWidth != null)
            ? Border.all(color: borderColor ?? context.colors.outline, width: borderWidth ?? 1.0)
            : null,
      ),
      clipBehavior: hasRadius ? Clip.antiAlias : Clip.none,
      child: image,
    );

    if (onImgTap != null) {
      return Stack(
        children: [
          container,
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              borderRadius: radius,
              clipBehavior: hasRadius ? Clip.antiAlias : Clip.none,
              child: InkWell(
                borderRadius: radius,
                onTap: onImgTap,
              ),
            ),
          ),
        ],
      );
    }

    return container;
  }
}

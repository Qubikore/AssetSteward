import 'package:material_ui/material_ui.dart';

/// Standard spacing and layout dimensions.
class Insets {
  const Insets._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double offset = 64;
}

class Pads {
  const Pads._();

  static const EdgeInsets zero = EdgeInsets.zero;

  // All sides
  static const EdgeInsets allXXS = EdgeInsets.all(Insets.xxs);
  static const EdgeInsets allXS = EdgeInsets.all(Insets.xs);
  static const EdgeInsets allSM = EdgeInsets.all(Insets.sm);
  static const EdgeInsets allMD = EdgeInsets.all(Insets.md);
  static const EdgeInsets allLG = EdgeInsets.all(Insets.lg);
  static const EdgeInsets allXL = EdgeInsets.all(Insets.xl);
  static const EdgeInsets allXXL = EdgeInsets.all(Insets.xxl);

  // Horizontal only
  static const EdgeInsets hXXS = EdgeInsets.symmetric(horizontal: Insets.xxs);
  static const EdgeInsets hXS = EdgeInsets.symmetric(horizontal: Insets.xs);
  static const EdgeInsets hSM = EdgeInsets.symmetric(horizontal: Insets.sm);
  static const EdgeInsets hMD = EdgeInsets.symmetric(horizontal: Insets.md);
  static const EdgeInsets hLG = EdgeInsets.symmetric(horizontal: Insets.lg);
  static const EdgeInsets hXL = EdgeInsets.symmetric(horizontal: Insets.xl);
  static const EdgeInsets hXXL = EdgeInsets.symmetric(horizontal: Insets.xxl);

  // Vertical only
  static const EdgeInsets vXXS = EdgeInsets.symmetric(vertical: Insets.xxs);
  static const EdgeInsets vXS = EdgeInsets.symmetric(vertical: Insets.xs);
  static const EdgeInsets vSM = EdgeInsets.symmetric(vertical: Insets.sm);
  static const EdgeInsets vMD = EdgeInsets.symmetric(vertical: Insets.md);
  static const EdgeInsets vLG = EdgeInsets.symmetric(vertical: Insets.lg);
  static const EdgeInsets vXL = EdgeInsets.symmetric(vertical: Insets.xl);
  static const EdgeInsets vXXL = EdgeInsets.symmetric(vertical: Insets.xxl);

  /// Helper to create symmetric padding
  static EdgeInsets sym({double h = 0, double v = 0}) => EdgeInsets.symmetric(horizontal: h, vertical: v);

  /// Helper to create custom padding with fallbacks
  static EdgeInsets only({
    double all = 0,
    double? h,
    double? v,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return EdgeInsets.only(
      top: top ?? v ?? all,
      bottom: bottom ?? v ?? all,
      left: left ?? h ?? all,
      right: right ?? h ?? all,
    );
  }
}

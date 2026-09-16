import 'package:material_ui/material_ui.dart';

/// Standard corner radiuses for UI elements.
class Corners {
  const Corners._();

  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double circle = 9999;

  static const Radius smRadius = Radius.circular(sm);
  static const Radius mdRadius = Radius.circular(md);
  static const Radius lgRadius = Radius.circular(lg);
  static const Radius xlRadius = Radius.circular(xl);
  static const Radius xxlRadius = Radius.circular(xxl);
  static const Radius xxxlRadius = Radius.circular(xxxl);
  static const Radius circleRadius = Radius.circular(circle);

  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static const BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static const BorderRadius xxxlBorder = BorderRadius.all(xxxlRadius);
  static const BorderRadius circleBorder = BorderRadius.all(circleRadius);
}

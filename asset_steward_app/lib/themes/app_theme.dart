import 'package:asset_steward_app/core/layout/corner.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

class AppThemes {
  static ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.indigo,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      appBarElevation: 0.0,
      subThemesData: const FlexSubThemesData(
        appBarScrolledUnderElevation: 0.0,
        defaultRadius: Corners.md,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorFocusedBorderWidth: 1.5,
        blendOnLevel: 10,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        inputDecoratorIsDense: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Outfit',
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.indigo,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 13,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      appBarElevation: 0.0,
      subThemesData: const FlexSubThemesData(
        appBarScrolledUnderElevation: 0.0,
        defaultRadius: Corners.md,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorFocusedBorderWidth: 1.5,
        blendOnLevel: 20,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        inputDecoratorIsDense: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Outfit',
    );
  }
}

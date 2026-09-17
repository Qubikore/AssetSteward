import 'package:asset_steward_app/core/layout/corner.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

class AppThemes {
  static final FlexSchemeColor _lightColors = FlexSchemeColor.from(
    primary: const Color(0xFF2563EB), // Modern Royal Blue
    secondary: const Color(0xFF0F172A), // Deep Slate
    tertiary: const Color(0xFF10B981), // Emerald Green
  );

  static final FlexSchemeColor _darkColors = FlexSchemeColor.from(
    primary: const Color(0xFF60A5FA), // Light Blue
    secondary: const Color(0xFF94A3B8), // Slate
    tertiary: const Color(0xFF34D399), // Light Emerald
  );

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      colors: _lightColors,
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
        
        // Custom Navigation Bar Theme
        navigationBarElevation: 0,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorOpacity: 1.0,
        navigationBarBackgroundSchemeColor: SchemeColor.surface,
        navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Outfit',
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      colors: _darkColors,
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
        
        // Custom Navigation Bar Theme
        navigationBarElevation: 0,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorOpacity: 1.0,
        navigationBarBackgroundSchemeColor: SchemeColor.surface,
        navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Outfit',
    );
  }
}

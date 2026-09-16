import 'package:asset_steward_app/core/di/di.dart';
import 'package:asset_steward_app/core/storage/key_value_storage.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  static const _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    final storage = di<KeyValueStorage>();
    final themeName = storage.getString(_themeKey);
    return ThemeMode.values.firstWhere((e) => e.name == themeName, orElse: () => ThemeMode.system);
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    di<KeyValueStorage>().saveString(_themeKey, mode.name);
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setThemeMode(newMode);
  }
}

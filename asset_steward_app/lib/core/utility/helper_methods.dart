import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

Null identityNull<T>(T a) => null;

Future wait(Function() fn, [double ms = 0]) => Future.delayed(Duration(milliseconds: ms.toInt()), fn);

class Haptic {
  const Haptic._();

  static void mediumImpact() => HapticFeedback.mediumImpact();
  static void lightImpact() => HapticFeedback.lightImpact();
  static void heavyImpact() => HapticFeedback.heavyImpact();
  static void selectionClick() => HapticFeedback.selectionClick();
  static void vibrate() => HapticFeedback.vibrate();
}

class Copier {
  const Copier._();
  static void copy(String? text) {
    if (text == null) return;
    Clipboard.setData(ClipboardData(text: text));
    Haptic.mediumImpact();
  }
}

class InputUtils {
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
  }

  static void unFocus() => primaryFocus?.unfocus();
}

T? onlyOnDebug<T>(T? data) => kDebugMode ? data : null;

bool isStrickPassword(String? password) {
  if (password == null) return false;
  if (password.length < 8) return false;
  if (!password.contains(RegExp(r'[\d+]'))) return false;
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
  return true;
}

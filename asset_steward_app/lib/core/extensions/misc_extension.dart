import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension ValueEx on ValueNotifier<bool> {
  void toggle() => value = !value;
  void truthy() => value = true;
  void falsey() => value = false;

  Future<T> waitUntil<T>(Future<T> Function() fn) async {
    try {
      truthy();
      final res = await fn();
      falsey();
      return res;
    } catch (e) {
      falsey();
      rethrow;
    } finally {
      falsey();
    }
  }
}

extension ValueTEx<T> on ValueNotifier<T> {
  void set(T value) => this.value = value;
}

extension EnumByName<T extends Enum> on Iterable<T> {
  T? tryByName(dynamic name) {
    try {
      if (name is T) return name;
      if (name is String) return byName(name);
    } catch (e) {
      return null;
    }
    return null;
  }
}

extension NumEx on num {
  String twoDigits([String padWith = '0']) => toString().padLeft(2, padWith);

  String currency({bool compact = false, int decimalDigits = 2}) {
    final digits = isInt ? 0 : decimalDigits;
    if (compact) {
      return NumberFormat.compactCurrency(name: 'BDT', symbol: 'Tk', decimalDigits: digits).format(normalize());
    }
    return NumberFormat.currency(name: 'BDT', symbol: 'Tk', decimalDigits: digits).format(normalize());
  }

  String compact() {
    return NumberFormat.compact().format(this);
  }

  String normalizeText() => normalize().toString();

  num normalize() {
    if (this is double) {
      final d = this as double;
      if (d == d.truncateToDouble()) {
        return d.toInt();
      }
    }

    return this;
  }

  bool get isInt {
    if (this is int) return true;
    return this == truncateToDouble();
  }
}

extension ObjEx<T extends Object?> on T {
  T log() {
    if (kDebugMode) inspect(this);
    return this;
  }
}

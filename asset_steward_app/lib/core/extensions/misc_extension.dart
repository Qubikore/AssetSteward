import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

extension DateTimeEx on DateTime {
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.isNegative || difference.inSeconds < 5) {
      return 'Just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins ${mins == 1 ? 'min' : 'mins'} ago';
    } else if (difference.inHours < 24) {
      final hrs = difference.inHours;
      return '$hrs ${hrs == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
}

extension WidgetListEx on Iterable<Widget> {
  List<Widget> separatedBy(Widget separator) {
    final result = <Widget>[];
    for (final item in this) {
      result.add(item);
      result.add(separator);
    }
    result.removeLast();
    return result;
  }

  List<Widget> gap(double v) => separatedBy(Gap(v));
}

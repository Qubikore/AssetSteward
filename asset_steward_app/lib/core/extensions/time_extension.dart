import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  String formatDate([String pattern = 'dd-MM-yyyy']) {
    return DateFormat(pattern).format(this);
  }

  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);

  DateTime fromTimeOfDay(TimeOfDay time) =>
      DateTime(year, month, day, time.hour, time.minute, second, millisecond, microsecond);

  DateTime get justDate => DateTime(year, month, day);

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

extension DurationEx on Duration {
  double progressOf(Duration? total) {
    if (total == null) return 0.0;
    if (total.inMilliseconds == 0) return 0.0;
    return inMilliseconds.clamp(0, total.inMilliseconds) / total.inMilliseconds;
  }

  Duration remaining(Duration total) {
    return (total - this);
  }
}

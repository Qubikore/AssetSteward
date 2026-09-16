import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

class Throttler {
  final Duration delay;
  bool _isReady = true;
  Timer? _timer;

  Throttler({this.delay = const Duration(milliseconds: 500)});

  void run(VoidCallback action) {
    if (_isReady) {
      action();
      _isReady = false;
      _timer = Timer(delay, () {
        _isReady = true;
      });
    }
  }

  void cancel() {
    _timer?.cancel();
    _isReady = true;
  }
}

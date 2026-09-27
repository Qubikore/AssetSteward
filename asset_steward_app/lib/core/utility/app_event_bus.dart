import 'dart:async';

/// Defines the base class for all application events.
abstract base class AppEvent {
  const AppEvent();
}

/// Event fired when the user's session expires (e.g. 401 Unauthorized).
final class SessionExpiredEvent extends AppEvent {
  const SessionExpiredEvent();
}

/// A strongly typed event bus for broadcasting application-wide events.
class AppEventBus {
  static final AppEventBus _instance = AppEventBus._internal();
  factory AppEventBus() => _instance;
  AppEventBus._internal();

  final _controller = StreamController<AppEvent>.broadcast();

  /// Stream of all events.
  Stream<AppEvent> get onEvent => _controller.stream;

  /// Fire an event to all listeners.
  void fire(AppEvent event) {
    _controller.add(event);
  }

  /// Listen for a specific type of event.
  Stream<T> on<T extends AppEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  void dispose() {
    _controller.close();
  }
}

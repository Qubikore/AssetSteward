import 'package:chirp/chirp.dart';

import 'string_extensions.dart';

typedef QMap = Map<String, Object?>;

extension QueryMapX on Map<String, String> {
  bool parseBool(String key, {bool fallback = false}) {
    return this[key]?.tryParseBool ?? fallback;
  }
}

extension MapEx<K, V> on Map<K, V> {
  Map<String, V> toStringKey() => map((k, v) => MapEntry('$k', v));

  Map<K, V> logJson([String? m]) {
    Chirp.info(m ?? 'Log Map', data: toStringKey());
    return this;
  }
}

extension RemoveNull<K, V> on Map<K, V?> {
  Map<K, V> removeNull() {
    final result = {...this}..removeWhere((_, v) => v == null);
    return result.map((key, value) => MapEntry(key, value as V));
  }

  Map<K, V> removeNullAndEmpty() {
    final it = removeNull();
    final result = it
      ..removeWhere(
        (k, v) => switch (v) {
          _ when v is String && v.isEmpty => true,
          _ when v is List && v.isEmpty => true,
          _ when v is Map && v.isEmpty => true,
          _ => false,
        },
      );
    return result.map((key, value) => MapEntry(key, value));
  }
}

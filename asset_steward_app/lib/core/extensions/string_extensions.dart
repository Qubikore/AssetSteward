extension StringX on String {
  bool? get tryParseBool => switch (toLowerCase()) {
    'true' || '1' || 'yes' => true,
    'false' || '0' || 'no' => false,
    _ => null,
  };

  String ifEmpty([String onEmpty = 'EMPTY']) {
    return isEmpty ? onEmpty : this;
  }

  String get low => toLowerCase();
  String get up => toUpperCase();
}

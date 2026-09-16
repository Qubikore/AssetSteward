extension StringX on String {
  bool? get tryParseBool => switch (toLowerCase()) {
    'true' || '1' || 'yes' => true,
    'false' || '0' || 'no' => false,
    _ => null,
  };
}

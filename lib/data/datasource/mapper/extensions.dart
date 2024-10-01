extension NonNullString on String? {
  String orEmpty() => this ?? "";
}

extension NonNullDouble on double? {
  double orZero() => this ?? 0.0;
}

extension NonNullInteger on int? {
  int orZero() => this ?? 0;
}

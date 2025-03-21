
extension StringExtension on String {
  double toDouble() {
    return double.tryParse(this) ?? 0;
  }

  num toNum() {
    return num.tryParse(this) ?? 0;
  }

  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  String capitalize() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return "${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}";
  }

  String toDollar() {
    return "\$${this ?? ''}";
  }

  String get amountValue {
    return trim().replaceAll(",", "");
  }
}
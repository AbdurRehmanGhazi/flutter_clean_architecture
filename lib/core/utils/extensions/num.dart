import 'package:intl/intl.dart';

extension NumberFormatting on num {
  // String toISFormatNumberWithCurrency() {
  //   // final formatter = NumberFormat('#,##0.00');
  //   final isWholeNumber = this % 1 == 0;
  //   final formatter = NumberFormat(isWholeNumber ? '#,##0.0' : '#,##0.00');
  //   return "${SharedPreference.getCurrencySymbol()}${formatter.format(this)}";
  // }

  String toISFormatNumber() {
    // final formatter = NumberFormat('#,##0.00');
    final isWholeNumber = this % 1 == 0;
    final formatter = NumberFormat(isWholeNumber ? '#,##0.0' : '#,##0.00');
    return formatter.format(this);
  }

  String toISFormatNumberWithoutDecimalPoint() {
    final formatter = NumberFormat('#,##0');
    return formatter.format(this);
  }
}

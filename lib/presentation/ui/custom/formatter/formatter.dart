import 'package:intl/intl.dart';

class Formatter {

  static String parseDate(int mills) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(mills);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static String parseDateTime(int mills) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(mills);
    String time = DateFormat.Hm().format(dateTime);
    return '$time, ${parseDate(mills)}';
  }

  static String formatCurrency(double amount) {
    bool isNegative = false;
    if (amount < 0) {
      isNegative = true;
      amount *= -1;
    }
    String formattedAmount = amount.toStringAsFixed(1);
    List<String> parts = formattedAmount.split('.');

    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? '.' + parts[1] : '';

    String formattedIntegerPart = '';
    for (int i = integerPart.length - 1, j = 0; i >= 0; i--, j++) {
      if (j != 0 && j % 3 == 0) {
        formattedIntegerPart = ',$formattedIntegerPart';
      }
      formattedIntegerPart = integerPart[i] + formattedIntegerPart;
    }
    String currency = '\$$formattedIntegerPart$decimalPart';
    if (currency.endsWith(".0")) {
      currency = currency.replaceAll(".0", "");
    }
    if (isNegative) {
      return "-$currency";
    } else {
      return currency;
    }
  }

  static String formatRange(int number) {
    if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(1)}M';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }

}
import 'package:intl/intl.dart';

abstract class CurrencyUtil {
  static String formatToUSD(double value) {
    final formatador = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '\$',
      decimalDigits: 0,
    );
    return formatador.format(value);
  }
}

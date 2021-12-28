import 'package:intl/intl.dart';

class DataUtils {
  static String numberFormat(double? value) {
    return NumberFormat("###,###,###").format(value);
  }

  static String simpleDateFormat(DateTime value) {
    return DateFormat("MM.dd").format(value);
  }
}
import 'package:intl/intl.dart';

String dateToString(DateTime dateTime) {
  return DateFormat.yMMMMEEEEd().format(dateTime).toString();
}

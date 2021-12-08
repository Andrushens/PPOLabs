import 'package:intl/intl.dart';

String parseDate(DateTime? date) {
  try {
    var format = DateFormat('MMM d, HH:mm a');
    return format.format(date!);
  } catch (e) {
    return '';
  }
}

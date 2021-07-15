import 'package:intl/intl.dart';
import 'package:netflix/config/constants.dart';
extension IntTimeExtension on int {

  //convert int timestamp to String having dateTimeFormat
  String timeFormat({String? dateTimeFormat}) {
    String format = (dateTimeFormat!=null && dateTimeFormat.isNotEmpty) ? dateTimeFormat : patternParseTimeServer;
    String date = DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(this));
    return date;
  }

}

extension StringTimeExtension on String {

  //convert String have dateTimeFormat to int milliseconds
  int convertStringToMillis({String? dateTimeFormat}) {
    if (this.isEmpty) {
      return 0;
    }
    String timeFormat = (dateTimeFormat!=null && dateTimeFormat.isNotEmpty) ? dateTimeFormat : patternParseTimeServer;
    return DateFormat(timeFormat).parse(this).millisecondsSinceEpoch;
  }


  //convert String timestamp to String having dateTimeFormat
  String timeFormat({String? dateTimeFormat}) {
    String timeFormat = (dateTimeFormat!=null && dateTimeFormat.isNotEmpty) ? dateTimeFormat : patternParseTimeServer;
    String date = DateFormat(timeFormat).format(DateTime.fromMillisecondsSinceEpoch(int.parse(this.isNotEmpty ? this : '0')));
    // print(DateTime.parse(date).toUtc().toString());
    return date;
  }
}



import 'package:intl/intl.dart';
import 'dart:io';

class LocaleFormats {
  static formatDateTime(DateTime date, {ignoreTime = true}) {
    var defaultLocale = getLocale();
    var dateFormatWithHours = DateFormat.MMMEd(defaultLocale).add_jm();
    var dateFormatWithoutHours = DateFormat.MMMEd(defaultLocale);

    String dateString;

    if (ignoreTime == true) {
      dateString = dateFormatWithoutHours.format(date);
      return dateString;
    }
    dateString = dateFormatWithHours.format(date);
    return dateString;
  }

  static getLocale() {
    String defaultLocale = Platform.localeName;

    return defaultLocale;
  }
}



// class Locale {
//   static dateFormat(DateTime date, {bool ignoreTime = false}) {
//     String formatWithHours = FORMAT_WITH_HOURS;
//     String formatWithoutHours = FORMAT_WITHOUT_HOURS;

//     if (ignoreTime == true) {
//       return DateFormat(formatWithoutHours).format(date);
//     }
//     return DateFormat(formatWithHours).format(date);
//   }
// }

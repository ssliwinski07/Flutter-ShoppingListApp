import 'package:intl/intl.dart';
import 'dart:io';


class LocaleFormats {
  static formatDateTime(DateTime date, {bool ignoreTime = true, String? languageCode}) {

    var dateFormatWithHours = DateFormat.MMMEd(languageCode).add_jm();
    var dateFormatWithoutHours = DateFormat.MMMEd(languageCode);

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

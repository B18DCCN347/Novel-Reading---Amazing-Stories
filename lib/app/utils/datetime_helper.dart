import 'package:intl/intl.dart';

class DateTimeHelpers {
  static final DateFormat dateFormatHHMMDDMMYYYY =
      DateFormat("HH:mm dd/MM/yyyy");
  static final DateFormat dateFormatDDMMYYYY = DateFormat("dd-MM-yyyy");
  static final DateFormat dateFormatDDMM = DateFormat("dd/MM");
  static final DateFormat dateFormatHHMM = DateFormat("HH:mm");

  static String formatHHMMDDMMYYYY(DateTime dateTime) {
    return dateFormatHHMMDDMMYYYY.format(dateTime);
  }

  static String formatDDMMYYYY(DateTime dateTime) {
    return dateFormatDDMMYYYY.format(dateTime);
  }

  static String formatDDMM(DateTime dateTime) {
    return dateFormatDDMM.format(dateTime);
  }

  static String formatHHMM(DateTime dateTime) {
    return dateFormatHHMM.format(dateTime);
  }

  static String durationToHHmmss(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String durationTommss(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static DateTime stringToDateTime(String data, String format) {
    return DateFormat(format).parse(data);
  }

  static String dateTimeToString(DateTime data, String format) {
    return DateFormat(format).format(data);
  }
}

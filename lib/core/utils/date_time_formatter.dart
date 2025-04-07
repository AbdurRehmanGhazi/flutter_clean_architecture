
import 'package:intl/intl.dart';

class DateTimeFormatter {
  // Static function to parse and reformat the date
  // static String formatDateTimeString(String? isoDate) {
  //   // Parse the input string as a DateTime object
  //   DateTime dateTime = DateTime.parse(isoDate ?? "");
  //
  //   // Format the DateTime object as "yyyy-MM-dd HH:mm:ss" (customize as needed)
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  //
  //   return formattedDate;
  // }

  static String formatDate(DateTime? isoDate) {

    if (isoDate != null) {
      return DateFormat('MMM dd, yyyy').format(isoDate.toLocal());
    }
    return "";
  }

  static String formatDateNumber(DateTime? isoDate) {

    if (isoDate != null) {
      return DateFormat('dd-MM-yyyy').format(isoDate.toLocal());
    }
    return "";
  }

  static String formatDateLeadWithDay(DateTime? isoDate) {

    if (isoDate != null) {
      return DateFormat('d MMM yy').format(isoDate.toLocal());
    }
    return "";
  }

  static String formatDateForAPI(DateTime? isoDate) {

    if (isoDate != null) {
      return DateFormat('yyyy-MM-dd').format(isoDate.toLocal());
    }
    return "";
  }

  static String formatDateTime(DateTime? isoDate) {

    if (isoDate != null) {
      return DateFormat('MMM d, yyyy hh:mm a').format(isoDate.toLocal());
    }
    return "";
  }

  static String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    // Format the minutes and seconds to always show two digits
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }
}
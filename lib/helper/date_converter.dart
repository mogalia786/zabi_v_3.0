import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  // static int differenceInMinute(String deliveryTime, String orderTime, int processingTime, String scheduleAt) {
  //   // 'min', 'hours', 'days'
  //   int minTime = processingTime != null ? processingTime : 0;
  //   if(deliveryTime != null && deliveryTime.isNotEmpty && processingTime == null) {
  //     try {
  //       List<String> timeList = deliveryTime.split('-'); // ['15', '20']
  //       minTime = int.parse(timeList[0]);
  //     }catch(e) {}
  //   }
  //   DateTime deliveryTime0 = dateTimeStringToDate(scheduleAt != null ? scheduleAt : orderTime).add(Duration(minutes: minTime));
  //   return deliveryTime0.difference(DateTime.now()).inMinutes;
  // }

  // static bool isBeforeTime(String dateTime) {
  //   if(dateTime == null) {
  //     return false;
  //   }
  //   DateTime scheduleTime = dateTimeStringToDate(dateTime);
  //   return scheduleTime.isBefore(DateTime.now());
  // }

  // static String localDateToIsoStringAMPM(DateTime dateTime) {
  //   return DateFormat('${_timeFormatter()} | d-MMM-yyyy ').format(dateTime.toLocal());
  // }
}

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

String timeFromNow(String dateStr) {
  DateTime date = DateTime.parse(dateStr);

  Jiffy targetDate = Jiffy.parse(dateStr);
  Jiffy now = Jiffy.now();

  int days = targetDate.diff(now, unit: Unit.day).toInt();
  int minutes = targetDate.diff(now, unit: Unit.minute).toInt();
  int weeks = targetDate.diff(now, unit: Unit.week).toInt();
  int months = targetDate.diff(now, unit: Unit.month).toInt();
  int years = targetDate.diff(now, unit: Unit.year).toInt();
  int hours = targetDate.diff(now, unit: Unit.hour).toInt();

  String result;
  if (years != 0) {
    result = "$years سنة";
  } else if (months != 0) {
    result = "$months شهر";
  } else if (weeks != 0) {
    result = "$weeks أسبوع";
  } else if (days != 0) {
    result = "$days يوم";
  } else if (hours != 0) {
    result = "$hours ساعات";
  } else {
    result = "$minutes دقائق";
  }

  var finalResult = result.split("-");
  return finalResult.join(" ");
}

List<String> convertToArabicTimeAndDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  
  final List<String> arabicDays = [
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت'
  ];

  String hour = DateFormat('h:mm a').format(dateTime);
  hour = hour.replaceAll('AM', 'ص').replaceAll('PM', 'م');

  String day = arabicDays[dateTime.weekday % 7];
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  String dayAndDate = '$day $formattedDate';

  return [hour, dayAndDate];
}
String formatDate(String dateStr) {

  DateTime date = DateTime.parse(dateStr);


  Map<int, String> monthsInArabic = {
    1: 'يناير',
    2: 'فبراير',
    3: 'مارس',
    4: 'أبريل',
    5: 'مايو',
    6: 'يونيو',
    7: 'يوليو',
    8: 'أغسطس',
    9: 'سبتمبر',
    10: 'أكتوبر',
    11: 'نوفمبر',
    12: 'ديسمبر'
  };

  int day = date.day;
  int month = date.month;
  int year = date.year;


  String monthInArabic = '';
  if (month == 1) {
    monthInArabic = 'يناير';
  } else if (month == 2) {
    monthInArabic = 'فبراير';
  } else if (month == 3) {
    monthInArabic = 'مارس';
  } else if (month == 4) {
    monthInArabic = 'أبريل';
  } else if (month == 5) {
    monthInArabic = 'مايو';
  } else if (month == 6) {
    monthInArabic = 'يونيو';
  } else if (month == 7) {
    monthInArabic = 'يوليو';
  } else if (month == 8) {
    monthInArabic = 'أغسطس';
  } else if (month == 9) {
    monthInArabic = 'سبتمبر';
  } else if (month == 10) {
    monthInArabic = 'أكتوبر';
  } else if (month == 11) {
    monthInArabic = 'نوفمبر';
  } else if (month == 12) {
    monthInArabic = 'ديسمبر';
  }

  return '$day $monthInArabic $year';
}
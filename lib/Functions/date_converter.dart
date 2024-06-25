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

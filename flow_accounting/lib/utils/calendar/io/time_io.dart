/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/21/22, 7:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */



import 'package:shamsi_date/shamsi_date.dart';

class TimeIO {

  static const int OneMonthMillisecond = 2629800000;
  static const int ThreeMonthsMillisecond = 7889400000;
  static const int SixMonthsMillisecond = 15778800000;
  static const int TwelveMonthsMillisecond = 31557600000;

  String humanReadableFarsi(DateTime inputDateTime) {

    Gregorian gregorianCalendar = Gregorian(inputDateTime.year, inputDateTime.month, inputDateTime.day, inputDateTime.hour, inputDateTime.minute, 0, 0);
    var iranianCalendar = gregorianCalendar.toJalali();

    String yearNumber = iranianCalendar.formatter.yyyy.toString();
    String dayNumber = iranianCalendar.formatter.dd.toString();

    String weekdayName = iranianCalendar.formatter.wN.toString();
    String monthName = iranianCalendar.formatter.mN.toString();

    return "" +
        weekdayName + "\n" +
        dayNumber + " " +
        monthName + "\n" +
        yearNumber;
  }

}
import 'package:flutter/material.dart';

int weeksOfYear(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1, 0, 0);
  final firstMonday = startOfYear.weekday;
  final daysInFirstWeek = 8 - firstMonday;
  final diff = date.difference(startOfYear);
  var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
  if (daysInFirstWeek > 3) {
    weeks += 1;
  }
  return weeks;
}

String acronymName(String name) {
  if (name.isEmpty) return '';
  List<String> listString = name.split(' ');
  if (listString.length == 1) {
    return listString.first.replaceAll(' ', '').characters.first.toUpperCase();
  }
  return listString.first.replaceAll(' ', '').characters.first.toUpperCase() +
      listString.last.replaceAll(' ', '').characters.first.toUpperCase();
}

int daysInMonth(DateTime date){
  var firstDayThisMonth =  DateTime(date.year, date.month, date.day);
  var firstDayNextMonth =  DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

String getDay(int d) {
  switch (d) {
    case 1:
      return 'T2';
    case 2:
      return 'T3';
    case 3:
      return 'T4';
    case 4:
      return 'T5';
    case 5:
      return 'T6';
    case 6:
      return 'T7';
    default:
      {
        return 'CN';
      }
  }
}
 int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
  }
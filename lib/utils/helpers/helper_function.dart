import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HelperFunction {


  static Size screenSize(BuildContext context){
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static String formatDate(dynamic date, {String format = 'yyyy-MM-dd'}) {
    try {
      DateTime parsedDate;

      if (date is String) {
        parsedDate = DateTime.parse(date);
      } else if (date is DateTime) {
        parsedDate = date;
      } else {
        throw Exception("Invalid date type");
      }

      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return date.toString();
    }
  }
  static bool parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    if (value is num) {
      return value == 1;
    }
    return false;
  }
}
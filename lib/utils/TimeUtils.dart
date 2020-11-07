import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:intl/intl.dart';
/*changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color);
  } on PlatformException catch (e) {
    print(e);
  }
}*/
String getTime(BuildContext context) {
  TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
  return timeOfDay.format(context);
}

Future<bool>checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connecteddddd');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
}
var timestamp = DateTime.now().millisecondsSinceEpoch;

// Date Format like '19 January 1970 1:39 PM'
String getLocalDate(int timestamp) {
  DateTime serverDatetime =
      new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  DateFormat formatter = new DateFormat('d MMMM yyyy');
  DateFormat time = new DateFormat.jm();
  var dateTime =
      '${formatter.format(serverDatetime)} ${time.format(serverDatetime)}' /*${time.format(server_datetime)}*/;
  return dateTime;
}

// Date Format like '19 Jan  1:39 PM'
String chatDate(int timestamp) {
  DateTime serverDatetime =
      new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  DateFormat formatter = new DateFormat('d MMM');
  DateFormat time = new DateFormat.jm();
  var dateTime =
      '${formatter.format(serverDatetime)} - ${time.format(serverDatetime)}' /*${time.format(server_datetime)}*/;
  return dateTime;
}

// Date Format like 19-01-1970 1:39 PM '11-11-2019'
String getDate(int timestamp) {
  DateTime serverDatetime =
      new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  DateFormat formatter = new DateFormat('d-MM-yyyy');
  var dateTime =
      '${formatter.format(serverDatetime)}' /*${time.format(server_datetime)}*/;
  return dateTime;
}

/// Returns the difference (in full days) between the provided date and today.
int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}

String timeAgoSinceDate(int timestamp, {bool numericDates = true}) {
  DateTime date = DateTime.now();
  DateTime date2 =
  new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  final difference = date.difference(date2);

if (difference.inDays >= 2) {
    return getDate(timestamp);
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return getDate(timestamp);
  }
}

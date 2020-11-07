import 'dart:io';

import 'package:intl/intl.dart';

import 'network/ApiHitter.dart';

class BaseRepository {
  final apiHitter = ApiHitter();
  final dio = ApiHitter.getDio();

  getCurrentTimeString() {
    final now = new DateTime.now();
    final formatter = new DateFormat('yyyy-MM-dd H:m:s');
    return formatter.format(now);
  }

  String getUtcTime() {
    return DateTime.now().toUtc().toString();
  }

  String getdevice() {
    if (Platform.isIOS)
      return "ios";
    else
      return "android";
  }
}

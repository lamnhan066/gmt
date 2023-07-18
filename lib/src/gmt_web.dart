import 'dart:async';

import 'package:gmt/src/utils.dart';
import 'package:http/http.dart' as http;

class GMTImpl {
  static Future<String?> now({
    List<String> urls = const [
      'https://www.example.com',
      'https://www.google.com',
    ],
    Duration? timeoutOfEach,
  }) async {
    http.Response? response;

    try {
      if (timeoutOfEach != null) {
        response = await http.head(Uri.base).timeout(timeoutOfEach);
      } else {
        response = await http.head(Uri.base);
      }

      if (response.statusCode != 200) {
        response = null;
        throw Exception('[GMT] ERROR: Get statusCode != 200');
      }

      printDebug('Get from current URL successfully');
    } catch (e) {
      printDebug('ERROR: Get from current URL error: $e');
    }
    String? dateTime = response?.headers['date'];
    if (dateTime != null && response!.statusCode == 200) {
      return dateTime;
    } else {
      return null;
    }
  }
}

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

    for (final url in urls) {
      try {
        if (timeoutOfEach != null) {
          response = await http.get(Uri.parse(url)).timeout(timeoutOfEach);
        } else {
          response = await http.get(Uri.parse(url));
        }

        if (response.statusCode != 200) {
          response = null;
          throw Exception('[GMT] ERROR: Get from $url statusCode != 200');
        }

        printDebug('Get from $url successfully');

        break;
      } catch (e) {
        printDebug('ERROR: Get from $url error: $e');
      }
    }

    String? dateTime = response?.headers['date'];
    if (dateTime != null && response!.statusCode == 200) {
      return dateTime;
    } else {
      return null;
    }
  }
}

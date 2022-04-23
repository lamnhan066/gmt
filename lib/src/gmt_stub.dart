import 'dart:async';

import 'package:http/http.dart' as http;

class GMTIpl {
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
          throw Exception('[GMT] error: get from $url statusCode != 200');
        }

        print('[GMT] get from $url successfully');

        break;
      } catch (e) {
        print('[GMT] error: get from $url error: $e');
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

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

    try {
      if (timeoutOfEach != null) {
        response = await http.get(Uri.base).timeout(timeoutOfEach);
      } else {
        response = await http.get(Uri.base);
      }

      if (response.statusCode != 200) {
        response = null;
        throw Exception('GMT get statusCode != 200');
      }

      print('[GMT] get from current URL successfully');
    } catch (e) {
      print('[GMT] error: get from current URL error: $e');
    }
    String? dateTime = response?.headers['date'];
    if (dateTime != null && response!.statusCode == 200) {
      return dateTime;
    } else {
      return null;
    }
  }
}

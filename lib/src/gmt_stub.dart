import 'dart:async';
import 'package:http/http.dart' as http;

class GMTIpl {
  static Future<String?> now() async {
    http.Response? response;
    try {
      response = await http.get(Uri.parse('https://www.example.com'));

      if (response.statusCode != 200) {
        throw Exception('GMT get statusCode != 200');
      }
    } catch (e) {
      print(
          'GMT get from example.com error: $e\nGMT try to get from gooogle.com...');
      try {
        response = await http.get(Uri.parse('https://www.google.com'));

        if (response.statusCode != 200) {
          throw Exception('GMT get statusCode != 200');
        }
      } catch (e1) {
        print(
            'GMT get from google.com error: $e1\nGMT can\'t get DateTime from internet!!!');
      }
    }
    String? dateTime = response?.headers['date'];
    if (response != null && response.statusCode == 200 && dateTime != null) {
      return dateTime;
    } else {
      return null;
    }
  }
}

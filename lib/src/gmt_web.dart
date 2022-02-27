import 'dart:async';
import 'package:http/http.dart' as http;

class GMTIpl {
  static Future<String?> now() async {
    http.Response? response;
    try {
      response = await http.get(Uri.base);

      if (response.statusCode != 200) {
        throw Exception('GMT get statusCode != 200');
      }
    } catch (e) {
      print(
          'GMT get from current URL error: $e\nGMT can\'t get DateTime from internet!!!');
    }
    String? dateTime = response?.headers['date'];
    if (response != null && response.statusCode == 200 && dateTime != null) {
      return dateTime;
    } else {
      return null;
    }
  }
}

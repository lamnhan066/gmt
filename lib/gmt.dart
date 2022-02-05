import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class GMT {
  /// Get current datetime in GMT from internet (example.com or google.com) and
  /// return DateTime in UTC.
  ///
  /// [returnLocalIfError] == true: Return local [DateTime.now()] if error or timeout.
  /// [returnLocalIfError] == false: Return [null] if error or timeout.
  static Future<DateTime?> now(
      {bool returnLocalIfError = false, Duration? timeout}) async {
    DateTime? now;
    try {
      if (timeout != null) {
        now = await _now().timeout(timeout, onTimeout: () => null);
      } else {
        now = await _now();
      }
    } catch (_) {}
    if (now == null && returnLocalIfError) {
      return DateTime.now();
    }
    return now;
  }

  static Future<DateTime?> _now() async {
    var response = await http.get(Uri.parse('https://www.example.com'));
    if (response.statusCode != 200) {
      response = await http.get(Uri.parse('https://www.google.com'));
    }
    String? dateTime = response.headers['date'];
    if (response.statusCode == 200 && dateTime != null) {
      return HttpDate.parse(dateTime).toUtc();
    } else {
      return null;
    }
  }
}

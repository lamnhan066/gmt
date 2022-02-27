import 'package:universal_io/io.dart';
import 'dart:async';
import 'gmt_web.dart' if (dart.library.io) 'gmt_stub.dart';

class GMT {
  /// Get current datetime in GMT from internet (example.com or google.com) and
  /// return DateTime in UTC.
  ///
  /// [returnLocalIfError] == true: Return local [DateTime.now()] if error or timeout.
  /// [returnLocalIfError] == false: Return [null] if error or timeout.
  static Future<DateTime?> now(
      {bool returnLocalIfError = false, Duration? timeout}) async {
    String? now;
    try {
      if (timeout != null) {
        now = await GMTIpl.now().timeout(timeout, onTimeout: () => null);
      } else {
        now = await GMTIpl.now();
      }
    } catch (e) {
      print('GMT error: $e');
    }
    if (now == null && returnLocalIfError) {
      return DateTime.now().toUtc();
    }
    return now == null ? null : HttpDate.parse(now);
  }
}

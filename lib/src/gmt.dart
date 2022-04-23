import 'dart:async';

import 'package:universal_io/io.dart';

import 'gmt_web.dart' if (dart.library.io) 'gmt_stub.dart';

class GMT {
  /// Get current datetime in GMT from internet (example.com, google.com or your own urls)
  /// and return DateTime in UTC.
  ///
  /// [urls] List of URLs to get the current date and time. This doed nothing on Web platform.
  ///
  /// [timeoutOfEach] Timeout of each URL.
  ///
  /// [timeout] Timeout of this whole function.
  ///
  /// [returnLocalIfError] == true: Return local [DateTime.now()] if error or timeout.
  /// [returnLocalIfError] == false: Return [null] if error or timeout.
  static Future<DateTime?> now({
    List<String> urls = const [
      'https://www.example.com',
      'https://www.google.com',
    ],
    Duration? timeoutOfEach,
    Duration? timeout,
    bool returnLocalIfError = false,
  }) async {
    String? now;
    try {
      if (timeout != null) {
        now = await GMTIpl.now(urls: urls, timeoutOfEach: timeoutOfEach)
            .timeout(timeout, onTimeout: () => null);
      } else {
        now = await GMTIpl.now(urls: urls, timeoutOfEach: timeoutOfEach);
      }
    } catch (e) {
      print('[GMT] error: $e');
    }
    if (now == null && returnLocalIfError) {
      return DateTime.now().toUtc();
    }
    return now == null ? null : HttpDate.parse(now).toUtc();
  }
}

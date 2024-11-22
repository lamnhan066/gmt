import 'dart:async';

import 'package:gmt/src/utils.dart';
import 'package:universal_io/io.dart';

import 'gmt_web.dart' if (dart.library.io) 'gmt_stub.dart';

class GMT {
  /// Only use this class as static.
  GMT._();

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
  ///
  /// [isDebug] Allow print debug text.
  static Future<DateTime?> now({
    List<String> urls = const [
      'https://1.1.1.1',
      'https://1.0.0.1',
      'https://8.8.8.8',
      'https://8.8.4.4',
      'https://www.example.com',
    ],
    Duration? timeoutOfEach,
    Duration? timeout,
    bool returnLocalIfError = false,
    bool isDebug = false,
  }) async {
    isDebugMode = isDebug;

    String? now;
    try {
      if (timeout != null) {
        now = await GMTImpl.now(urls: urls, timeoutOfEach: timeoutOfEach)
            .timeout(timeout, onTimeout: () => null);
      } else {
        now = await GMTImpl.now(urls: urls, timeoutOfEach: timeoutOfEach);
      }
    } catch (e) {
      printDebug('ERROR: $e');
    }
    if (now == null && returnLocalIfError) {
      return DateTime.now().toUtc();
    }
    return now == null ? null : HttpDate.parse(now).toUtc();
  }
}

import 'dart:async';

import 'package:gmt/src/utils.dart';

class GMTImpl {
  static Future<String?> now({
    required List<String> urls,
    required Duration? timeoutOfEach,
  }) =>
      getNow(urls: [Uri.base.path], timeoutOfEach: timeoutOfEach);
}

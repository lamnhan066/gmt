import 'dart:async';

import 'package:gmt/gmt.dart';
import 'package:test/test.dart';

void main() {
  test('test GMT.now', () async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      print(await GMT.now(urls: [
        'https://www.example.com',
        'https://www.google.com',
      ], timeoutOfEach: Duration(seconds: 1)));
    });

    await Future.delayed(const Duration(seconds: 10));
  });
}

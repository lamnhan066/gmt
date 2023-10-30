import 'dart:async';

import 'package:gmt/gmt.dart';
import 'package:test/test.dart';

void main() {
  test('test GMT.now', () async {
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final time = await GMT.now(
        urls: [
          'https://www.example.com',
          'https://www.google.com',
        ],
        timeoutOfEach: Duration(seconds: 1),
      );

      print(time);
      expect(time, equals(isA<DateTime>()));
    });

    await Future.delayed(const Duration(seconds: 10));
    timer.cancel();
  });
}

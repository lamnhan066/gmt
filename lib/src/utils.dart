import 'dart:async';

import 'package:http/http.dart' as http;

bool isDebugMode = false;

void printDebug(Object? object) => isDebugMode ? print('[GMT] $object') : null;

Future<String?> getNow({
  required List<String> urls,
  required Duration? timeoutOfEach,
}) async {
  final completer = Completer<String?>();
  int counter = urls.length;
  for (final url in urls) {
    checkUrl(url, timeoutOfEach).then((value) {
      if (completer.isCompleted) return;

      if (value != null) {
        completer.complete(value);
        return;
      }

      counter--;
      if (counter == 0) completer.complete(null);
    });
  }
  return completer.future;
}

Future<String?> checkUrl(String url, Duration? timeoutOfEach) async {
  try {
    http.Response? response;
    if (timeoutOfEach != null) {
      response = await http.head(Uri.parse(url)).timeout(timeoutOfEach);
    } else {
      response = await http.head(Uri.parse(url));
    }

    if (response.statusCode != 200) {
      response = null;
      printDebug('[GMT] ERROR: Get from $url statusCode != 200');
      return null;
    }

    printDebug('Get from $url successfully');
    return response.headers['date'];
  } catch (e) {
    printDebug('ERROR: Get from $url error: $e');
  }
  return null;
}

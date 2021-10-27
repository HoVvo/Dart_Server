import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test('Check http status response 200', () async {
    final response = await http.get(Uri.parse('http://localhost:8080/'));

    expect(response.statusCode, HttpStatus.ok);
  });
}

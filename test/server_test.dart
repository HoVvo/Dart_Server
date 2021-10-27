import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

void main() {
  late HttpServer server;
  late Uri url;
  setUp(() async {
    var app = Router();
    app.get('/', (Request req) {
      return Response.ok('Hello World');
    });
    var handler = const Pipeline().addHandler(app);
    server = await io.serve(handler, 'localhost', 8080);
    url = Uri.parse('http://${server.address.host}:${server.port}');
    print(url);
  });

  tearDown(() async {
    await server.close(force: true);
  });

  test('Check http status response 200', () async {
    final response = await http.get(url);
    expect(response.statusCode, HttpStatus.ok);
  });
}

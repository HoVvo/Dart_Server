import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'controller/user_api.dart';
import 'helpers/handleCors.dart';

const _hostname = 'localhost';
const int _port = 8080;

final server_handler = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};

late Router app = Router();

void main(List<String> args) async {
  // Static file
  app.get('/assets/<file|.*>', createStaticHandler('public'));

  //Api Routing
  app.get('/', (Request req) {
    return Response.ok('Hello World');
  });

  app.mount('/users/', userApi().router);

  // Return Html response
  app.get('/<name|.*>', (Request request, String name) {
    final indexFile = File('public/index.html').readAsStringSync();
    return Response.ok(indexFile, headers: {'content-type': 'text/html'});
  });

  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  var server = await io.serve(handler, _hostname, _port);
  print('Serving at http://${server.address.host}:${server.port}');
}

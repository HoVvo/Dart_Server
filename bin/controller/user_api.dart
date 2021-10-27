import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class userApi {
  final _headers = {'content-type': 'application/json'};

  Router get router {
    final router = Router();

    router.get('/', (Request req) {
      return Response.ok(
        '{"user":["HoVo"]}',
        headers: _headers,
      );
    });

    return router;
  }
}

//im_port 'package:flutter/foundation.dart';

class API {
  final _host = '192.168.1.9';
  final _port = 8000;

  Uri authUri(String auth) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/auth/$auth',
      );

  Uri recentHousesUri(int page) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/house',
        queryParameters: {'page': page},
      );

  Uri housesRegionUri(int regionId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/$regionId/house',
      );

  Uri houseUri(int houseId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/house/$houseId',
      );
}

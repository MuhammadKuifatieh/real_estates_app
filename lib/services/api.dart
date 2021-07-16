//im_port 'package:flutter/foundation.dart';

class API {
  final _host = '192.168.1.8';
  final _port = 8000;

  Uri authUri(String auth) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/auth/$auth',
      );

  Uri recentHousesUri(String page) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/house',
        queryParameters: {'page': page},
      );

  Uri houseUri(String houseId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/house/$houseId',
      );

  Uri userLikedHouses(String page) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/userLikeshouse',
        queryParameters: {'page': page},
      );

  Uri mostLikedHouses(String page) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/mostLikehouse',
        queryParameters: {'page': page},
      );

  Uri userHouses() => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/userhouse',
      );

  Uri storeHouse(String regionId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/$regionId/house',
      );

  Uri housesInRegion(String regionId, String page) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/$regionId/house',
        queryParameters: {'page': page},
      );

  Uri updateHouse(String houseId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/house/$houseId',
      );

  Uri nearestHousesUri(String page) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/nearesthouse',
        queryParameters: {'page': page},
      );

  Uri regionIndex() => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/region',
      );

  Uri likeStore(String houseId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/like/$houseId',
      );

  Uri dislikeStore(String houseId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/dislike/$houseId',
      );

  Uri commentIndex(String houseId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/comment/$houseId',
      );

  Uri repliesIndex(String commentId) => Uri(
        scheme: 'http',
        host: _host,
        port: _port,
        path: 'api/reply/$commentId',
      );
}

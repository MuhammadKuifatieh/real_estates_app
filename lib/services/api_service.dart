import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './api.dart';
import '../models/house.dart';

class APIService {
  final API api = API();
  var authHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<http.Response> signUp(
      {@required String email,
      @required String password,
      @required String name}) {
    return http.post(
      api.authUri('register'),
      headers: authHeaders,
      body: json.encode(
        {
          'name': name,
          'email': email,
          'password': password,
          'c_password': password,
          'dateOfBirth': '1999-01-22',
          'gender': 'male',
          'phone': '0949096735',
        },
      ),
    );
  }

  Future<http.Response> logIn(
      {@required String email, @required String password}) {
    return http.post(
      api.authUri('login'),
      headers: authHeaders,
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getDetails({@required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.authUri('details'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getRecentHouses(
      {@required int page, @required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.recentHousesUri(page.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getMostLikedHouses(
      {@required int page, @required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.mostLikedHouses(page.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getNearestHouses(
      {@required int page,
      @required String token,
      double lat,
      double long}) async {
    var responseData;
    try {
      final response = await http.post(
        api.nearestHousesUri(page.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(
          {
            'lattitude': lat.toString(),
            'longitude': long.toString(),
          },
        ),
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getUserLikedHouses(
      {@required int page, @required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.userLikedHouses(page.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getUserHouses({@required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.userHouses(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getHousesInRegion(
      {@required int regionId,
      @required int page,
      @required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.housesInRegion(regionId.toString(), page.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> storeHouseInRegion(
      {@required int regionId,
      @required String token,
      @required Map<String, dynamic> house}) async {
    var responseData;
    try {
      final response = await http.post(
        api.storeHouse(regionId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(house),
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
      log(responseData.toString());
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> updateHouse(
      {@required int houseId,
      @required String token,
      @required House house}) async {
    var responseData;
    try {
      final response = await http.put(
        api.houseUri(houseId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: houseToJson(house),
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> deleteHouse(
      {@required int houseId, @required String token}) async {
    var responseData;
    try {
      final response = await http.delete(
        api.houseUri(houseId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getAllRegions({@required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.regionIndex(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<String> addLike(
      {@required int houseId, @required String token}) async {
    var responseData;
    try {
      final response = await http.post(
        api.likeStore(houseId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as String;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<String> addDisLike(
      {@required int houseId, @required String token}) async {
    var responseData;
    try {
      final response = await http.delete(
        api.dislikeStore(houseId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as String;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getAllComments(
      {@required int houseId, @required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.commentIndex(houseId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> getAllReplies(
      {@required int commentId, @required String token}) async {
    var responseData;
    try {
      final response = await http.get(
        api.repliesIndex(commentId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> storeComment(
      {@required int houseId, @required String token, String content}) async {
    var responseData;
    try {
      final response = await http.post(
        api.commentIndex(houseId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({'content': content}),
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }

  Future<Map<String, dynamic>> storeReply(
      {@required int commentId, @required String token, String content}) async {
    var responseData;
    try {
      final response = await http.post(
        api.repliesIndex(commentId.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({'content': content}),
      );
      responseData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      // log(error.toString());
      throw error;
    }
    // log(responseData.toString());
    return responseData;
  }
}

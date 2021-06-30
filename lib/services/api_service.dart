import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './api.dart';

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
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './api.dart';

class APIService {
  final API api = API();
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<http.Response> signUp(
      {@required String email,
      @required String password,
      @required String name}) {
    return http.post(
      api.authUri('register'),
      headers: headers,
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
      headers: headers,
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
  }
}

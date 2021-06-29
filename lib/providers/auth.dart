import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class Auth with ChangeNotifier {
  String _token;
  final apiSrevice = APIService();

  bool get isAuth => _token != null;
  String get token => _token;

  Future<void> signUp(
      {@required String email,
      @required String password,
      @required String name}) async {
    final response =
        await apiSrevice.signUp(email: email, password: password, name: name);
    if (response.statusCode >= 400)
      throw HttpException('Authorization failed please try again later');
    _token = json.decode(response.body)['success']['token'];
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
  }

  Future<bool> autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return false;
    _token = prefs.getString('token');
    notifyListeners();
    return true;
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    final response = await apiSrevice.logIn(email: email, password: password);
    if (response.statusCode >= 400)
      throw HttpException('Authorization failed please try again later');
    _token = json.decode(response.body)['success']['token'];
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
  }
}

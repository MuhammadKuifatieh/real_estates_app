import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:real_estates_app/models/user_detail.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class Auth with ChangeNotifier {
  String _token;
  UserDetail _user;
  final apiSrevice = APIService();

  bool get isAuth => _token != null;
  String get token => _token;
  UserDetail get user => _user;

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
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('token', _token);
  }

  // Future<bool> autoLogIn() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('token')) return false;
  //   _token = prefs.getString('token');
  //   notifyListeners();
  //   return true;
  // }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    final response = await apiSrevice.logIn(email: email, password: password);
    if (response.statusCode >= 400)
      throw HttpException('Authorization failed please try again later');
    _token = json.decode(response.body)['success']['token'];
    notifyListeners();
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('token', _token);
  }

  fetchUser() async {
    final response = await apiSrevice.getDetails(token: _token);
    log(response.toString());
    final newUser = UserDetail.fromJson(response['user']);
    _user = newUser;
    notifyListeners();
  }

  logOut() {
    _token = null;
    notifyListeners();
  }
}

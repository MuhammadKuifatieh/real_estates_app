import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/post.dart';
// import '../models/user.dart';
import '../dummy_data.dart';
import '../models/house.dart';
import '../services/api_service.dart';

class HomeProvider with ChangeNotifier {
  final String token;
  HomeProvider(this.token, this._recentPosts, this.lastPage);
  int lastPage;
  var _recentPosts;
  var _mostLikedPosts;
  var _nearYouPosts;
  final apiService = APIService();
  // final User user = User(
  //   email: 'a7madsi15@gmail.com',
  //   firstName: 'AHMED',
  //   lastName: 'SI',
  //   id: 1,
  //   phone: '0949096735',
  //   profileImageUrl: 'assets/images/22.jpg',
  // );
  List<House> get recentPosts => [..._recentPosts];
  List<House> get mostLikedPosts => [..._mostLikedPosts];
  List<House> get nearYouPosts => [..._nearYouPosts];

  Future<void> fetchRecentNewPage(
      int pageKey, PagingController<int, House> pagingController) async {
    try {
      log('enter fetch');
      final jsonMap =
          await apiService.getRecentHouses(page: pageKey, token: token);
      final listItems = jsonMap['data'];
      // final newItems = listItems
      //     .map((object) => House.fromJson(object))
      //     .toList() as List<House>;H
      List<House> newItems = [];
      for (var item in listItems) {
        newItems.add(House.fromJson(item));
      }
      // log(newItems.toString());
      lastPage = jsonMap['lastPage'];
      // log(newItems.toString());
      if (pageKey == lastPage) pagingController.appendLastPage(newItems);
      final nextPageKey = pageKey + 1;
      log(newItems.toString());
      pagingController.appendPage(newItems, nextPageKey);
      // log(newItems.toString());
    } catch (error) {
      pagingController.error = error;
      log(error.toString());
    }
  }

  Future<void> fetchRecentFirstPage() async {
    // log('fetching');
    // log(token);
    final responseMap = await apiService.getRecentHouses(page: 1, token: token);
    // log(responseMap.toString());

    final recnetList = responseMap['data'];
    final loadedList =
        recnetList.map((entry) => House.fromJson(entry)).toList();
    // log(loadedList.toString());
    _recentPosts = loadedList;
    notifyListeners();
  }

  Future<void> fetchMostLikeNewPage(
      int pageKey, PagingController<int, House> pagingController) async {
    try {
      log('enter fetch');
      final jsonMap =
          await apiService.getMostLikedHouses(page: pageKey, token: token);
      final listItems = jsonMap['data'];
      // final newItems = listItems
      //     .map((object) => House.fromJson(object))
      //     .toList() as List<House>;H
      List<House> newItems = [];
      for (var item in listItems) {
        newItems.add(House.fromJson(item));
      }
      // log(newItems.toString());
      lastPage = jsonMap['lastPage'];
      // log(newItems.toString());
      if (pageKey == lastPage) pagingController.appendLastPage(newItems);
      final nextPageKey = pageKey + 1;
      log(newItems.toString());
      pagingController.appendPage(newItems, nextPageKey);
      // log(newItems.toString());
    } catch (error) {
      pagingController.error = error;
      log(error.toString());
    }
  }

  Future<void> fetchMostLikeFirstPage() async {
    // log('fetching');
    // log(token);
    final responseMap =
        await apiService.getMostLikedHouses(page: 1, token: token);
    // log(responseMap.toString());

    final recnetList = responseMap['data'];
    final loadedList =
        recnetList.map((entry) => House.fromJson(entry)).toList();
    // log(loadedList.toString());
    _mostLikedPosts = loadedList;
    notifyListeners();
  }

  Future<void> fetchNearestNewPage(
      int pageKey, PagingController<int, House> pagingController) async {
    try {
      log('enter fetch');
      final jsonMap =
          await apiService.getNearestHouses(page: pageKey, token: token);
      final listItems = jsonMap['data'];
      // final newItems = listItems
      //     .map((object) => House.fromJson(object))
      //     .toList() as List<House>;H
      List<House> newItems = [];
      for (var item in listItems) {
        newItems.add(House.fromJson(item));
      }
      // log(newItems.toString());
      lastPage = jsonMap['lastPage'];
      // log(newItems.toString());
      if (pageKey == lastPage) pagingController.appendLastPage(newItems);
      final nextPageKey = pageKey + 1;
      log(newItems.toString());
      pagingController.appendPage(newItems, nextPageKey);
      // log(newItems.toString());
    } catch (error) {
      pagingController.error = error;
      log(error.toString());
    }
  }

  Future<void> fetchNearestFirstPage() async {
    // log('fetching');
    // log(token);
    final responseMap =
        await apiService.getNearestHouses(page: 1, token: token);
    // log(responseMap.toString());

    final recnetList = responseMap['data'];
    final loadedList =
        recnetList.map((entry) => House.fromJson(entry)).toList();
    // log(loadedList.toString());
    _nearYouPosts = loadedList;
    notifyListeners();
  }

  Future<void> fetchFirstAll() async {
    await fetchRecentFirstPage();
    await fetchNearestFirstPage();
    await fetchMostLikeFirstPage();
  }

  storeHouse(int regionId, Map<String, dynamic> houseMap) async {
    // House house = House.fromJson(houseMap);
    await apiService.storeHouseInRegion(
        regionId: regionId, token: token, house: houseMap);
  }
}

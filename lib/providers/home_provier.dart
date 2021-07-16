import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:real_estates_app/models/region.dart';

import '../models/post.dart';
// import '../models/user.dart';
import '../dummy_data.dart';
import '../models/house.dart';
import '../services/api_service.dart';

class HomeProvider with ChangeNotifier {
  final String token;
  HomeProvider(
    this.token,
    this.lastPage,
    this._recentPosts,
    this._mostLikedPosts,
    this._nearYouPosts,
    this._myLikedPosts,
  );
  int lastPage;
  List<House> _recentPosts;
  List<House> _mostLikedPosts;
  List<House> _nearYouPosts;
  List<House> _myLikedPosts;
  List<Region> _regions = [];

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
  List<House> get myLikedPosts => [..._myLikedPosts];
  List<House> get nearYouPosts => [..._nearYouPosts];
  List<Region> get region => [..._regions];

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
    try {
      // log('fetching');
      // log(token);
      final responseMap =
          await apiService.getRecentHouses(page: 1, token: token);
      // log(responseMap.toString());
      // log('have response\n\n');

      final recnetList = responseMap['data'];
      final List<House> loadedList = [];
      // recnetList.map((entry) => House.fromJson(entry)).toList();
      for (var item in recnetList) loadedList.add(House.fromJson(item));
      // log("heey endddd\n\n");
      _recentPosts = loadedList;
      // log(_recentPosts.toString());
    } catch (e) {
      log(e.toString());
      throw e;
    }
    // notifyListeners();
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
    try {
      // log('fetching likes');
      // log(token);
      final responseMap =
          await apiService.getMostLikedHouses(page: 1, token: token);
      // log('likes response');
      // log(responseMap.toString());

      final recnetList = responseMap['data'];
      final List<House> loadedList = [];
      // recnetList.map((entry) => House.fromJson(entry)).toList();
      for (var item in recnetList) loadedList.add(House.fromJson(item));
      //  log(loadedList.toString());
      _mostLikedPosts = loadedList;
      // notifyListeners();

      // log(_recentPosts.toString());
      // log('likes ended');
    } catch (e) {
      log(e.toString());
    }
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
    try {
      log('fetching nearest');
      // log(token);
      final responseMap = await apiService.getNearestHouses(
          page: 1, token: token, lat: 14.7, long: 44.2);
      // log(responseMap.toString());

      final recnetList = responseMap['data'];
      final List<House> loadedList = [];
      // recnetList.map((entry) => House.fromJson(entry)).toList();
      for (var item in recnetList) loadedList.add(House.fromJson(item));
      // log(loadedList.toString());
      _nearYouPosts = loadedList;
      if (_nearYouPosts == null) _nearYouPosts = [];
      // notifyListeners();
      // log(_recentPosts.toString());
      log('ended nearest');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchFirstAll() async {
    log('enter fetch all');
    await fetchRecentFirstPage();
    log('fetched recent');
    await fetchMostLikeFirstPage();
    log('fetched likes');
    await fetchNearestFirstPage();
    log('fetched nearest');
    log('leave fetch all');
    notifyListeners();
  }

  Future<void> fetchMytLikeNewPage(
      int pageKey, PagingController<int, House> pagingController) async {
    try {
      log('enter fetch');
      final jsonMap =
          await apiService.getUserLikedHouses(page: pageKey, token: token);
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
      if (newItems.length == 0) pagingController.appendLastPage(newItems);
      final nextPageKey = pageKey + 1;
      log(newItems.toString());
      pagingController.appendPage(newItems, nextPageKey);
      // log(newItems.toString());
    } catch (error) {
      pagingController.error = error;
      log(error.toString());
    }
  }

  Future<void> fetchMyLikeFirstPage() async {
    // log('fetching');
    // log(token);
    final responseMap =
        await apiService.getUserLikedHouses(page: 1, token: token);
    // log(responseMap.toString());

    final recnetList = responseMap['data'];
    final loadedList =
        recnetList.map((entry) => House.fromJson(entry)).toList();
    // log(loadedList.toString());
    _mostLikedPosts = loadedList;
    notifyListeners();
  }

  storeHouse(int regionId, Map<String, dynamic> houseMap) async {
    // House house = House.fromJson(houseMap);
    await apiService.storeHouseInRegion(
        regionId: regionId, token: token, house: houseMap);
  }

  storeLike(houseId) async {
    await apiService.addLike(houseId: houseId, token: token);
    notifyListeners();
  }

  storedisLike(houseId) async {
    await apiService.addDisLike(houseId: houseId, token: token);
    notifyListeners();
  }

  fetchRegion() async {
    final responseMap = await apiService.getAllRegions(token: token);
    // log(responseMap.toString());

    final recnetList = responseMap['data'];
    List<Region> loadedList = [];
    for (var item in recnetList) {
      loadedList.add(Region.fromJson(item));
    }
    log(loadedList.toString());
    _regions = loadedList;
    notifyListeners();
  }

  Future<void> fetchRegionNewPage(int pageKey,
      PagingController<int, House> pagingController, int regionId) async {
    try {
      log('enter fetch');
      final jsonMap = await apiService.getHousesInRegion(
          regionId: regionId, page: pageKey, token: token);
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
      log(newItems.toString());
      if (newItems.length == 0) pagingController.appendLastPage(newItems);
      final nextPageKey = pageKey + 1;
      log(newItems.toString());
      pagingController.appendPage(newItems, nextPageKey);
      // log(newItems.toString());
    } catch (error) {
      pagingController.error = error;
      log(error.toString());
    }
  }

  Future<void> fetchRegionFirstPage(int regionId) async {
    // log('fetching');
    // log(token);
    final responseMap = await apiService.getHousesInRegion(
        regionId: regionId, page: 1, token: token);
    // log(responseMap.toString());

    final recnetList = responseMap['data'];
    final loadedList =
        recnetList.map((entry) => House.fromJson(entry)).toList();
    // log(loadedList.toString());
    _mostLikedPosts = loadedList;
    notifyListeners();
  }
}

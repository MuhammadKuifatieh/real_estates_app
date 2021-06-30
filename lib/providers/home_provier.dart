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
  var _mostLikedPosts = dummyMostLikes;
  var _nearYouPosts = dummyRecent;
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
  List<Post> get mostLikedPosts => [..._mostLikedPosts];
  List<Post> get nearYouPosts => [..._nearYouPosts];

  Future<void> fetchNewPage(
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

  Future<void> fetchFirstPage() async {
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
}

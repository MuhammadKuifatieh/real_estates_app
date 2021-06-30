import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/likes_screen.dart';
import '../screens/profile_screen.dart';

class PageIndex with ChangeNotifier {
  int _pageIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    SearchScren(),
    LikesScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'Home',
    'Search',
    'Likes',
    'profile',
  ];
  Widget get page => pages[_pageIndex];
  String get tilte => titles[_pageIndex];
  setPageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }
}

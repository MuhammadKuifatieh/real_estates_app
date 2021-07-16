import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/likes_screen.dart';
import '../screens/profile_screen.dart';

class PageIndex with ChangeNotifier {
  int _pageIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    LikesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'Home',
    'Likes',
    'Find',
    'profile',
  ];
  Widget get page => pages[_pageIndex];
  String get tilte => titles[_pageIndex];
  int get pageIndex => _pageIndex;
  setPageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }
}

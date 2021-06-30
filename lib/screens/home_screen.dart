import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/my_app_bar.dart';
import '../screens/show_more_sceen.dart';
import '../widgets/post_list.dart';
import '../providers/home_provier.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final _recentList = _homeProvider.recentPosts;
    final _mostLikedPosts = _homeProvider.mostLikedPosts;
    final _nearYouPosts = _homeProvider.nearYouPosts;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            titleRow(text: 'Recent Posts', list: _recentList),
            PostList(list: _recentList),
            titleRow(text: 'Most Likes', list: _recentList),
            PostList(list: _mostLikedPosts),
            titleRow(text: 'Near You', list: _recentList),
            PostList(list: _nearYouPosts),
          ],
        ),
      ),
    );
  }
  
  titleRow({text, list}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ShowMoreScreen.routeName,
                    arguments: {'list': list, 'text': text},
                  );
                },
                child: Text('show more >>')),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../widgets/my_app_bar.dart';
import '../screens/add_post_screen.dart';
import '../screens/post_detail_screen.dart';
// import '../screens/post_screen.dart';
// import '../models/post.dart';
import '../providers/home_provier.dart';
import '../screens/new_post_screen.dart';
import '../widgets/post_widget.dart';
import '../widgets/new_post_widget.dart';
import '../models/house.dart';

class ShowMoreScreen extends StatefulWidget {
  static const routeName = '/show_more_screen';
  @override
  _ShowMoreScreenState createState() => _ShowMoreScreenState();
}

class _ShowMoreScreenState extends State<ShowMoreScreen> {
  final PagingController<int, House> _pagingController =
      PagingController(firstPageKey: 1);
  Map<String, dynamic> argArray;
  // List<House> list;
  String title;
  ScrollController _scrollViewController;
  bool isScrollingDown = false;

  @override
  void initState() {
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse)
        setState(() {
          isScrollingDown = true;
        });

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward)
        setState(() {
          isScrollingDown = false;
        });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    argArray =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    // list = argArray['list'];
    title = argArray['title'];
    if (title == 'Recent Posts') {
      _pagingController.addPageRequestListener((pageKey) {
        Provider.of<HomeProvider>(context, listen: false)
            .fetchRecentNewPage(pageKey, _pagingController);
      });
    }
    if (title == 'Most Likes')
      _pagingController.addPageRequestListener((pageKey) {
        Provider.of<HomeProvider>(context, listen: false)
            .fetchMostLikeNewPage(pageKey, _pagingController);
      });
    if (title == 'Near You')
      _pagingController.addPageRequestListener((pageKey) {
        Provider.of<HomeProvider>(context, listen: false)
            .fetchNearestNewPage(pageKey, _pagingController);
      });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = _homeProvider.user;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: title,
      ),
      body: PagedListView.separated(
          pagingController: _pagingController,
          padding: EdgeInsets.all(8),
          builderDelegate: PagedChildBuilderDelegate<House>(
              itemBuilder: (context, house, _) {
            return NewPostWidget(house);
          }),
          separatorBuilder: (context, _) {
            return SizedBox(
              height: 0,
            );
          }),
      floatingActionButton: (!isScrollingDown)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewPostScreen.routeName);
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

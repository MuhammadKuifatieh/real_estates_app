import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../widgets/new_post_widget.dart';
import '../models/house.dart';
import '../providers/home_provier.dart';

class LikesScreen extends StatefulWidget {
  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final PagingController<int, House> _pagingController =
      PagingController(firstPageKey: 1);
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
     _pagingController.addPageRequestListener((pageKey) {
      Provider.of<HomeProvider>(context, listen: false)
          .fetchNewPage(pageKey, _pagingController);
    });
    super.didChangeDependencies();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

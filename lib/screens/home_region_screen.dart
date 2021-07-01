import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../widgets/new_post_widget.dart';
import '../models/house.dart';
import '../providers/home_provier.dart';
import '../widgets/my_app_bar.dart';

class HomeRegionScreen extends StatefulWidget {
  static const roueName = '/home_region_Screen';
  @override
  _HomeRegionScreenState createState() => _HomeRegionScreenState();
}

class _HomeRegionScreenState extends State<HomeRegionScreen> {
  final PagingController<int, House> _pagingController =
      PagingController(firstPageKey: 1);
  ScrollController _scrollViewController;
  bool isScrollingDown = false;
  Map<String, dynamic> argArray;
  int regionId;
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
    regionId = argArray['regionId'];
    _pagingController.addPageRequestListener((pageKey) {
      Provider.of<HomeProvider>(context, listen: false)
          .fetchRegionNewPage(pageKey, _pagingController, 1);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: "House In Region",
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
    );
  }
}

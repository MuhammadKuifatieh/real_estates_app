import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:real_estates_app/screens/post_detail_screen.dart';

import '../widgets/my_app_bar.dart';
import '../screens/add_post_screen.dart';
import '../screens/post_detail_screen.dart';
// import '../screens/post_screen.dart';
import '../models/post.dart';
import '../providers/home_provier.dart';
import '../screens/new_post_screen.dart';
import '../widgets/post_widget.dart';
import '../models/user.dart';

class ShowMoreScreen extends StatefulWidget {
  static const routeName = '/show_more_screen';
  @override
  _ShowMoreScreenState createState() => _ShowMoreScreenState();
}

class _ShowMoreScreenState extends State<ShowMoreScreen> {
  Map<String, dynamic> argArray;
  List<Post> list;
  String text;
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
    list = argArray['list'];
    text = argArray['text'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final user = _homeProvider.user;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: text,
      ),
      body: ListView.builder(
        controller: _scrollViewController,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(8),
              width: size.width * .8,
              height: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          PostDetailScreen.routeName,
                          arguments: {'post': list[index]});
                    },
                    child: Container(
                      width: size.width * 0.8,
                      height: size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                          image: Image.asset(
                            list[index].mainImageUrl,
                          ).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(' ${user.firstName} ${user.lastName}'),
                          Text(list[index].location),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(list[index].likesCount.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.mode_comment_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(list[index].likesCount.toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
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

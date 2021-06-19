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
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: text,
      ),
      body: ListView.builder(
        controller: _scrollViewController,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PostDetailScreen.routName,
                  arguments: {'post': list[index]});
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      image: DecorationImage(
                          image: Image.asset(
                            list[index].mainImageUrl,
                          ).image,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('owner : ${user.firstName} ${user.lastName}'),
                        Text(list[index].location),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                Text(list[index].likesCount.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: Colors.blue,
                                ),
                                Text(list[index].likesCount.toString()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
                Navigator.of(context).pushNamed(AddPostScreen.routeName);
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

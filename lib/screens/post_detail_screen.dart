import 'package:flutter/material.dart';

import '../widgets/movie_detail_header.dart';
import '../widgets/description_widget.dart';
import '../widgets/photo_scroller.dart';
//import '../widgets/actor_scroller.dart';
// import '../models/post.dart';
import '../models/house.dart';

class PostDetailScreen extends StatefulWidget {
  static String routeName = '/post-detail';

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Map<String, dynamic> argArray;
  House house;
  bool flag;

  @override
  void didChangeDependencies() {
    flag = false;
    argArray =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    house = argArray['house'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailHeader(house),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DescriptionWidget(),
            ),
            PhotoScroller(house.otherImage),
            SizedBox(height: 20.0),
            // ActorScroller(movie.actors),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              spreadRadius: 1,
                              color: Colors.black38,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Show Comments',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}

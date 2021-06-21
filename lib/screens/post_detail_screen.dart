import 'package:flutter/material.dart';

import '../widgets/movie_detail_header.dart';
import '../widgets/description_widget.dart';
import '../widgets/photo_scroller.dart';
//import '../widgets/actor_scroller.dart';
import '../models/post.dart';

class PostDetailScreen extends StatefulWidget {
  static String routName = '/post-detail';

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Map<String, dynamic> argArray;
  Post post;

  @override
  void didChangeDependencies() {
    argArray =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    post = argArray['post'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailHeader(post),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DescriptionWidget(post.description),
            ),
            PhotoScroller(post.imageUrls),
            SizedBox(height: 20.0),
            // ActorScroller(movie.actors),
            Center(
              child: IconButton(
                iconSize: 70,
                icon: Icon(
                  Icons.favorite_border_outlined,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}

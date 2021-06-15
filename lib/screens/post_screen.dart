import 'package:flutter/material.dart';

import '../models/post.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/curve_clipper.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post_screen';
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Map<String, dynamic> argArray;
  Post post;
  bool flagLike = false;
  bool flagDislike = false;

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
      appBar: MyAppBar(
        context: context,
        title: 'add new post',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(post.mainImageUrl).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Owner  :  ${post.userName}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Loctation : ${post.location}",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            color: (flagLike)
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              flagLike = !flagLike;
                              flagDislike = false;
                            });
                          },
                          tooltip: 'like',
                        ),
                        Text((post.likesCount + (flagLike ? 1 : 0)).toString())
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_down,
                            color: (flagDislike)
                                ? Theme.of(context).errorColor
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              flagDislike = !flagDislike;
                              flagLike = false;
                            });
                          },
                          tooltip: 'dislike',
                        ),
                        Text((post.dislikesCount + (flagDislike ? 1 : 0))
                            .toString())
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

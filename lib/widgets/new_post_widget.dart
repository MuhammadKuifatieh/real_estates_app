import 'package:flutter/material.dart';

import '../screens/post_detail_screen.dart';
import '../models/house.dart';

class NewPostWidget extends StatefulWidget {
  House house;
  NewPostWidget(this.house);
  @override
  _NewPostWidgetState createState() => _NewPostWidgetState();
}

class _NewPostWidgetState extends State<NewPostWidget> {
  var size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // margin: EdgeInsets.all(8),
        width: size.width * 0.8,
        height: size.width * 1.2,
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
                Navigator.of(context).pushNamed(PostDetailScreen.routeName,
                    arguments: {'house': widget.house});
              },
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                    image: Image.network(
                      widget.house.baseImage,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(' '),
                    Text(widget.house.streetAddress),
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
                            Text(widget.house.countlikes.toString()),
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
                            Text(widget.house.countcomments.toString()),
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
  }
}

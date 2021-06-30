import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final String title;
  final int likesCount;
  final int commentsCount;
  final String location;
  final String imageUrl;

  PostWidget(
      {@required this.commentsCount,
      @required this.likesCount,
      @required this.location,
      @required this.title,
      @required this.imageUrl});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width*.8,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 1,
                  color: Colors.black38,
                  offset: Offset(0, 2),
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              height: MediaQuery.of(context).size.width,
              image: AssetImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          left: 10,
          child: Container(
            padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width*.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              color: Colors.white60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.location,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Text(widget.likesCount.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        Text(widget.commentsCount.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

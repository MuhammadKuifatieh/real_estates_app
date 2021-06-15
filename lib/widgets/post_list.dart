import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/post.dart';
import '../widgets/post_widget.dart';
import '../screens/post_screen.dart';

class PostList extends StatelessWidget {
  final List<Post> list;
  PostList({this.list});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, _) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(PostScreen.routeName,
                arguments: {'post': list[index]});
          },
          child: PostWidget(
            commentsCount: list[index].likesCount,
            imageUrl: list[index].mainImageUrl,
            likesCount: list[index].likesCount,
            location: list[index].location,
            title: list[index].userName,
          ),
        );
      },
      options: CarouselOptions(
        height: 350,
        viewportFraction: 0.69,
        enableInfiniteScroll: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 11),
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

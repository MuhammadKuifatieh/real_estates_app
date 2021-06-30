import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/house.dart';
import '../widgets/post_widget.dart';
import '../screens/post_detail_screen.dart';
import '../providers/home_provier.dart';

class PostList extends StatelessWidget {
  final List<House> list;
  PostList({this.list});

  @override
  Widget build(BuildContext context) {
    // final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // final user = _homeProvider.user;
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, _) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              PostDetailScreen.routeName,
              arguments: {
                'house': list[index],
              },
            );
          },
          child: PostWidget(
            commentsCount: list[index].countcomments,
            imageUrl: list[index].baseImage,
            likesCount: list[index].countlikes,
            location: list[index].streetAddress,
            title: list[index].user.name,
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width,
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

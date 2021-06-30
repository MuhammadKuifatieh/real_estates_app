import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../widgets/post_widget.dart';
import '../screens/post_detail_screen.dart';
import '../providers/home_provier.dart';

class PostList extends StatelessWidget {
  final List<Post> list;
  PostList({this.list});

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final user = _homeProvider.user;
    return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, _) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              PostDetailScreen.routeName,
              arguments: {
                'post': list[index],
              },
            );
          },
          child: PostWidget(
            commentsCount: list[index].likesCount,
            imageUrl: list[index].mainImageUrl,
            likesCount: list[index].likesCount,
            location: list[index].location,
            title: '${user.firstName} ${user.lastName}',
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

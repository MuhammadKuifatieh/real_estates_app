import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'arc_banner_image.dart';
import '../providers/home_provier.dart';
//import '../models/post.dart';
import '../models/house.dart';
// import '../models/models.dart';
// import 'poster.dart';
// import 'rating_information.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.house);
  final House house;

  // List<Widget> _buildCategoryChips(TextTheme textTheme) {
  //   return movie.categories.map((category) {
  //     return Padding(
  //       padding: const EdgeInsets.only(right: 8.0),
  //       child: Chip(
  //         label: Text(category),
  //         labelStyle: textTheme.caption,
  //         backgroundColor: Colors.black12,
  //       ),
  //     );
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // var user = _homeProvider.user;
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          house.user.name,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
         'Price : \$${house.price.toString()} ',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 9.0),
        // RatingInformation(movie),
        // SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            label: Text(house.streetAddress),
            labelStyle: textTheme.caption,
            backgroundColor: Colors.black12,
          ),
        ),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(house.baseImage),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.375,
                  image: NetworkImage(house.user.image),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}

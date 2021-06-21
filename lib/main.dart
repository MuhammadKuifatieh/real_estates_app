import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
// import './screens/post_screen.dart';
import './screens/show_more_sceen.dart';
import './screens/add_post_screen.dart';
import './screens/post_detail_screen.dart';
import './screens/new_post_screen.dart';
import './providers/home_provier.dart';
// import './models/movie_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          // PostScreen.routeName: (context) => PostScreen(),
          ShowMoreScreen.routeName: (context) => ShowMoreScreen(),
          AddPostScreen.routeName: (context) => AddPostScreen(),
          PostDetailScreen.routName: (context) => PostDetailScreen(),
          NewPostScreen.routName: (context) => NewPostScreen(),
        },
      ),
    );
  }
}

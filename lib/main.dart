import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
// import './screens/post_screen.dart';
import './screens/show_more_sceen.dart';
import './screens/add_post_screen.dart';
import './screens/post_detail_screen.dart';
import './screens/new_post_screen.dart';
import './screens/login_screen.dart';
import './providers/home_provier.dart';
import './providers/auth.dart';
// import './models/movie_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.autoLogIn(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    else
                      return LoginScreen();
                  },
                ),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            // PostScreen.routeName: (context) => PostScreen(),
            ShowMoreScreen.routeName: (context) => ShowMoreScreen(),
            AddPostScreen.routeName: (context) => AddPostScreen(),
            PostDetailScreen.routeName: (context) => PostDetailScreen(),
            NewPostScreen.routeName: (context) => NewPostScreen(),
          },
        ),
      ),
    );
  }
}

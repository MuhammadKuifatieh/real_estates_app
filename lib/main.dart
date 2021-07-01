import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_estates_app/models/house.dart';
import 'package:real_estates_app/screens/home_region_screen.dart';

import './screens/home_screen.dart';
// import './screens/post_screen.dart';
import './screens/show_more_sceen.dart';
import './screens/add_post_screen.dart';
import './screens/post_detail_screen.dart';
import './screens/new_post_screen.dart';
import './screens/login_screen.dart';
import './providers/home_provier.dart';
import './providers/auth.dart';
import './providers/page_index.dart';
import './screens/comment_screen.dart';
import './screens/main_screen.dart';
// import './models/movie_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageIndex>(create: (_) => PageIndex()),
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, HomeProvider>(
          create: (_) => HomeProvider('', [], 0),
          update: (_, auth, previousHomeProvider) {
            return HomeProvider(
              auth.token,
              previousHomeProvider.recentPosts ?? [],
              previousHomeProvider.lastPage,
            );
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth ? MainScreen() : LoginScreen(),
          // : FutureBuilder(
          //     future: auth.autoLogIn(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting)
          //         return Center(
          //           child: CircularProgressIndicator(
          //             backgroundColor: Colors.blue,
          //           ),
          //         );
          //       else
          //         return LoginScreen();
          //     },
          //   ),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            // PostScreen.routeName: (context) => PostScreen(),
            ShowMoreScreen.routeName: (context) => ShowMoreScreen(),
            AddPostScreen.routeName: (context) => AddPostScreen(),
            PostDetailScreen.routeName: (context) => PostDetailScreen(),
            NewPostScreen.routeName: (context) => NewPostScreen(),
            CommentScreen.routeName: (context) => CommentScreen(),
            HomeRegionScreen.roueName: (context) => HomeRegionScreen(),
          },
        ),
      ),
    );
  }
}

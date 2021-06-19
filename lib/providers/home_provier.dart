import 'package:flutter/cupertino.dart';

import '../models/post.dart';
import '../models/user.dart';
import '../dummy_data.dart';

class HomeProvider with ChangeNotifier {
  var _recentPosts = dummyRecent;
  var _mostLikedPosts = dummyMostLikes;
  var _nearYouPosts = dummyRecent;
  final User user = User(
    email: 'a7madsi15@gmail.com',
    firstName: 'AHMED',
    lastName: 'SI',
    id: 1,
    phone: '0949096735',
    profileImageUrl: 'assets/images/22.jpg',
  );
  List<Post> get recentPosts => [..._recentPosts];
  List<Post> get mostLikedPosts => [..._mostLikedPosts];
  List<Post> get nearYouPosts => [..._nearYouPosts];
}

import 'package:flutter/cupertino.dart';

import '../models/post.dart';
import '../dummy_data.dart';

class HomeProvider with ChangeNotifier {
  var _recentPosts = dummyRecent;
  var _mostLikedPosts = dummyMostLikes;
  var _nearYouPosts = dummyNearYou;

  List<Post> get recentPosts => [..._recentPosts];
  List<Post> get mostLikedPosts => [..._mostLikedPosts];
  List<Post> get nearYouPosts => [..._nearYouPosts];
}

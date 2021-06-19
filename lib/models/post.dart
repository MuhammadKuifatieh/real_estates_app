class Post {
  final int id;
  final int userId;
  DateTime date;
  int likesCount;
  //int dislikesCount;
  String mainImageUrl;
  int houseId;
  String location;
  // String userName;
  String saleOrRent;
  String discription;
  List<String> imageUrls;
  Post({
    this.id,
    this.discription,
    this.houseId,
    this.date,
    this.saleOrRent,
    // this.dislikesCount,
    this.likesCount,
    this.userId,
    this.location,
    this.mainImageUrl,
    this.imageUrls,
  });
}

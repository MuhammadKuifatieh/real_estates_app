class Post {
  final int id;
  final int userId;
  DateTime date;
  int likesCount;
  int dislikesCount;
  String mainImageUrl;
  int houseId;
  String location;
  String userName;
  Post(
      {this.id,
      this.houseId,
      this.date,
      this.dislikesCount,
      this.likesCount,
      this.userId,
      this.location,
      this.mainImageUrl,
      this.userName});
}

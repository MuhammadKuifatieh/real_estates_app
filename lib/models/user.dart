class User {
  final int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String profileImageUrl;

  User(
      {this.profileImageUrl,
      this.lastName,
      this.email,
      this.firstName,
      this.id,
      this.phone});
}

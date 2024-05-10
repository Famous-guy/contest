class User {
  final String message;
  // final String profilePhoto;
  final String username;
  final String contestID;

  User({
    required this.message,
    // required this.profilePhoto,
    required this.username,
    required this.contestID,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        message: json['message'],
      
        contestID: json['contest_id']);
  }
}







// how to get json data thats not emited to server in socket.io flutter
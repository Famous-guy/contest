class LeaderboardEntry {
  final String id;
  final int count;
  final UserDetails? userDetails;

  LeaderboardEntry({
    required this.id,
    required this.count,
    this.userDetails,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['_id'],
      count: json['count'],
      userDetails: json.containsKey('userDetails')
          ? UserDetails.fromJson(json['userDetails'])
          : null,
    );
  }
}

class UserDetails {
  final String id;
  final String fullName;
  final String email;
  final String username;
  final double balance;
  final String currency;
  final String country;
  final String createdAt;
  UserDetails(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.username,
      required this.balance,
      required this.currency,
      required this.country,
      required this.createdAt});

  // factory UserDetails.fromJson(Map<String, dynamic> json) {
  //   return UserDetails(
  //     id: json['_id'],
  //     fullName: json['fullName'],
  //     email: json['email'],
  //     username: json['username'],
  //     balance: json['balance']['amount'].toDouble(),
  //     currency: json['balance']['currency'],
  //     country: json['country'],
  //     createdAt: json['createdAt'],
  //   );
  // }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    try {
      return UserDetails(
        id: json['_id'] ?? '',
        fullName: json['fullName'] ?? '',
        email: json['email'] ?? '',
        username: json['username'] ?? '',
        balance: (json['balance'] != null && json['balance']['amount'] != null)
            ? json['balance']['amount'].toDouble()
            : 0.0,
        currency: json['balance']?['currency'] ?? '',
        country: json['country'] ?? '',
        createdAt: json['createdAt'] ?? '',
      );
    } catch (e) {
      print('Error parsing createdAt: $e');
      return UserDetails(
        id: '',
        fullName: '',
        email: '',
        username: '',
        balance: 0.0,
        currency: '',
        country: '',
        createdAt: '',
      );
    }
  }
}

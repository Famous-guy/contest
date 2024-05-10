class UserData {
  final Map<String, dynamic> balance;
  final Map<String, dynamic> cashback;
  final List<dynamic> interests;
  final String id;
  final String fullName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserData({
    required this.balance,
    required this.cashback,
    required this.interests,
    required this.id,
    required this.fullName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      balance: json['balance'],
      cashback: json['cashback'],
      interests: json['interests'],
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class UserData {
  final String publicKey;
  final String email;
  final String phone;
  final String accountName;
  final String currency;
  final String accountId;
  final String businessId;
  final String token;

  UserData({
    required this.publicKey,
    required this.email,
    required this.phone,
    required this.accountName,
    required this.currency,
    required this.accountId,
    required this.businessId,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      publicKey: json['publicKey'],
      email: json['email'],
      phone: json['phone'],
      accountName: json['account_name'],
      currency: json['currency'],
      accountId: json['accountId'],
      businessId: json['businessId'],
      token: json['token'],
    );
  }
}

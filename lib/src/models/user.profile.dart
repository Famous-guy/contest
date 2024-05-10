

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  Balance balance;
  Cashback cashback;
  String id;
  String fullName;
  String email;
  List<dynamic> interests;
  String country;
  String username;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UserProfile({
    required this.balance,
    required this.cashback,
    required this.id,
    required this.fullName,
    required this.email,
    required this.interests,
    required this.country,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        balance: Balance.fromJson(json["balance"]),
        cashback: Cashback.fromJson(json["cashback"]),
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        interests: List<dynamic>.from(json["interests"].map((x) => x)),
        country: json["country"],
        username: json["username"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance.toJson(),
        "cashback": cashback.toJson(),
        "_id": id,
        "fullName": fullName,
        "email": email,
        "interests": List<dynamic>.from(interests.map((x) => x)),
        "country": country,
        "username": username,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Balance {
  String currency;
  int amount;

  Balance({
    required this.currency,
    required this.amount,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        currency: json["currency"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "amount": amount,
      };
}

class Cashback {
  int amount;
  String value;

  Cashback({
    required this.amount,
    required this.value,
  });

  factory Cashback.fromJson(Map<String, dynamic> json) => Cashback(
        amount: json["amount"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "value": value,
      };
}

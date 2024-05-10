import 'dart:convert';

List<Contests> contestsFromJson(String str) =>
    List<Contests>.from(json.decode(str).map((x) => Contests.fromJson(x)));

String contestsToJson(List<Contests> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contests {
  String id;
  String productCode;
  String productId;
  String productName;
  String videoUrl;
  String currency;
  int amount;
  List<dynamic> tapData;
  List<dynamic> supporters;
  bool completed;
  String category;
  DateTime startTime;
  final String startTime2;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<String> likes;

  Contests({
    required this.id,
    required this.productCode,
    required this.productId,
    required this.productName,
    required this.videoUrl,
    required this.currency,
    required this.amount,
    required this.tapData,
    required this.supporters,
    required this.completed,
    required this.category,
    required this.startTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.likes,
    required this.startTime2,
  });

  factory Contests.fromJson(Map<String, dynamic> json) => Contests(
      id: json["_id"],
      productCode: json["productCode"],
      productId: json["productId"],
      productName: json["productName"],
      videoUrl: json['videoURL'],
      currency: json["currency"],
      amount: json["amount"],
      tapData: List<dynamic>.from(json["tapData"].map((x) => x)),
      supporters: List<dynamic>.from(json["supporters"].map((x) => x)),
      completed: json["completed"],
      category: json["category"],
      startTime: DateTime.parse(json["startTime"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
      likes: List<String>.from(json["likes"].map((x) => x)),
      startTime2: json['startTime']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productCode": productCode,
        "productId": productId,
        "productName": productName,
        "videoURL": videoUrl,
        "currency": currency,
        "amount": amount,
        "tapData": List<dynamic>.from(tapData.map((x) => x)),
        "supporters": List<dynamic>.from(supporters.map((x) => x)),
        "completed": completed,
        "category": category,
        "startTime": startTime.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "startTime2": startTime2,
        "likes": List<dynamic>.from(likes.map((x) => x)),
      };
}

class Contest1 {
  final String id;
  final String productCode;
  final String productId;
  final String productName;
  final String videoURL;
  final String currency;
  final int amount;
  final List<List<Map<String, dynamic>>> tapData;
  final List<Map<String, dynamic>> supporters;
  final bool completed;
  final String category;
  final String startTime;
  final DateTime startTime2;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<String> likes;

  Contest1({
    required this.id,
    required this.startTime2,
    required this.productCode,
    required this.productId,
    required this.productName,
    required this.videoURL,
    required this.currency,
    required this.amount,
    required this.tapData,
    required this.supporters,
    required this.completed,
    required this.category,
    required this.startTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.likes,
  });

  factory Contest1.fromJson(Map<String, dynamic> json) {
    return Contest1(
      id: json['_id'],
      productCode: json['productCode'],
      productId: json['productId'],
      productName: json['productName'],
      videoURL: json['videoURL'],
      currency: json['currency'],
      amount: json['amount'],
      startTime2: DateTime.parse(json["startTime"]),
      tapData: List<List<Map<String, dynamic>>>.from(json['tapData'].map(
          (data) => List<Map<String, dynamic>>.from(
              data.map((item) => Map<String, dynamic>.from(item))))),
      supporters: List<Map<String, dynamic>>.from(
          json['supporters'].map((item) => Map<String, dynamic>.from(item))),
      completed: json['completed'],
      category: json['category'],
      startTime: json['startTime'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      likes: List<String>.from(json['likes']),
    );
  }
}

// To parse this JSON data, do
//
//     final newContestModel = newContestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<NewContestModel> newContestModelFromJson(String str) =>
    List<NewContestModel>.from(
        json.decode(str).map((x) => NewContestModel.fromJson(x)));

String newContestModelToJson(List<NewContestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewContestModel {
  final String startTime;
  final int contestAmount;
  final String currency;
  final String productName;
  final String productCode;
  final String productId;
  final String videoUrl;
  final int amount;
  final List<Supporter> supporters;
  final List<String> likes;
  final String contestId;
  final bool completed;
  final String category;
  final List<List<GameDatum>> gameData;

  NewContestModel({
    required this.startTime,
    required this.contestAmount,
    required this.currency,
    required this.productName,
    required this.productCode,
    required this.productId,
    required this.videoUrl,
    required this.amount,
    required this.supporters,
    required this.likes,
    required this.contestId,
    required this.completed,
    required this.category,
    required this.gameData,
  });

  NewContestModel copyWith({
    String? startTime,
    int? contestAmount,
    String? currency,
    String? productName,
    String? productCode,
    String? productId,
    String? videoUrl,
    int? amount,
    List<Supporter>? supporters,
    List<String>? likes,
    String? contestId,
    bool? completed,
    String? category,
    List<List<GameDatum>>? gameData,
  }) =>
      NewContestModel(
        startTime: startTime ?? this.startTime,
        contestAmount: contestAmount ?? this.contestAmount,
        currency: currency ?? this.currency,
        productName: productName ?? this.productName,
        productCode: productCode ?? this.productCode,
        productId: productId ?? this.productId,
        videoUrl: videoUrl ?? this.videoUrl,
        amount: amount ?? this.amount,
        supporters: supporters ?? this.supporters,
        likes: likes ?? this.likes,
        contestId: contestId ?? this.contestId,
        completed: completed ?? this.completed,
        category: category ?? this.category,
        gameData: gameData ?? this.gameData,
      );

  factory NewContestModel.fromJson(Map<String, dynamic> json) =>
      NewContestModel(
        startTime: json["startTime"],
        contestAmount: json["contestAmount"],
        currency: json["currency"],
        productName: json["productName"],
        productCode: json["productCode"],
        productId: json["productId"],
        videoUrl: json["videoURL"],
        amount: json["amount"],
        supporters: List<Supporter>.from(
            json["supporters"].map((x) => Supporter.fromJson(x))),
        likes: List<String>.from(json["likes"].map((x) => x)),
        contestId: json["contestId"],
        completed: json["completed"],
        category: json["category"],
        gameData: json["gameData"] == null
            ? []
            : List<List<GameDatum>>.from(json["gameData"].map((x) =>
                List<GameDatum>.from(x.map((x) => GameDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "contestAmount": contestAmount,
        "currency": currency,
        "productName": productName,
        "productCode": productCode,
        "productId": productId,
        "videoURL": videoUrl,
        "amount": amount,
        "supporters": List<dynamic>.from(supporters.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "contestId": contestId,
        "completed": completed,
        "category": category,
        "gameData": List<dynamic>.from(
            gameData.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class GameDatum {
  final int currentCount;
  final String msg;
  final String clickTime;
  final String userId;
  final String username;

  GameDatum({
    required this.currentCount,
    required this.msg,
    required this.clickTime,
    required this.userId,
    required this.username,
  });

  GameDatum copyWith({
    int? currentCount,
    String? msg,
    String? clickTime,
    String? userId,
    String? username,
  }) =>
      GameDatum(
        currentCount: currentCount ?? this.currentCount,
        msg: msg ?? this.msg,
        clickTime: clickTime ?? this.clickTime,
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  factory GameDatum.fromJson(Map<String, dynamic> json) => GameDatum(
        currentCount: json["currentCount"],
        msg: json["msg"],
        clickTime: json["clickTime"],
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "currentCount": currentCount,
        "msg": msg,
        "clickTime": clickTime,
        "userId": userId,
        "username": username,
      };
}

class Supporter {
  final String userId;
  final String username;

  Supporter({
    required this.userId,
    required this.username,
  });

  Supporter copyWith({
    String? userId,
    String? username,
  }) =>
      Supporter(
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  factory Supporter.fromJson(Map<String, dynamic> json) => Supporter(
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
      };
}

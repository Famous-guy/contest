import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VoucherProvider extends ChangeNotifier {
  List<Voucher> _vouchers = [];
  bool _isLoading = false;
  bool _hasData = false;
  bool _isEmpty = false;
  bool get isLoading => _isLoading;
  bool get hasData => _hasData;
  bool get isEmpty => _isEmpty;
  List<Voucher> get vouchers => _vouchers;

  Future<void> fetchVouchers() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    try {
      _isLoading = true;
      final url = Uri.parse(
          'https://contest-api.100pay.co/api/v1/contest/get-vouchers');
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        _isLoading = false;
        _hasData = true;
        final List<dynamic> responseData = json.decode(response.body);
        _vouchers = responseData.map((json) => Voucher.fromJson(json)).toList();
        notifyListeners();
      } else {
        _isLoading = false;
        _hasData = true;
        _isEmpty = true;
        throw Exception('Failed to load vouchers');
      }
    } catch (e) {}
  }
}

class Voucher {
  final String id;
  final String contestId;
  final double discount;
  final String voucherCurrency;
  final String userId;
  final bool isValid;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  Voucher({
    required this.id,
    required this.contestId,
    required this.discount,
    required this.voucherCurrency,
    required this.userId,
    required this.isValid,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['_id'],
      contestId: json['contestId'],
      discount: json['discount'].toDouble(),
      voucherCurrency: json['voucherCurrency'],
      userId: json['userId'],
      isValid: json['isValid'],
      code: json['code'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

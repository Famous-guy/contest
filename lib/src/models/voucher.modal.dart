class Voucher {
  final String id;
  final String contestId;
  final num discount;
  final String voucherCurrency;
  final String userId;
  final bool isValid;
  final DateTime expirationDate;
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
    required this.expirationDate,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory Voucher.fromJson(Map<String, dynamic> json) {
  //   return Voucher(
  //     id: json['_id'],
  //     contestId: json['contestId'],
  //     discount: json['discount'],
  //     voucherCurrency: json['voucherCurrency'],
  //     userId: json['userId'],
  //     isValid: json['isValid'],
  //     expirationDate: DateTime.parse(json['expirationDate']),
  //     code: json['code'],
  //     createdAt: DateTime.parse(json['createdAt']),
  //     updatedAt: DateTime.parse(json['updatedAt']),
  //   );
  // }

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['_id'] ?? '',
      contestId: json['contestId'] ?? '',
      discount: json['discount'] ?? 0,
      voucherCurrency: json['voucherCurrency'] ?? '',
      userId: json['userId'] ?? '',
      isValid: json['isValid'] ?? false,
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'])
          : DateTime.now(),
      code: json['code'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}

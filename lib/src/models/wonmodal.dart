class ContestModal {
  final String id;
  final String productCode;
  final String productId;
  final String productName;
  final String videoURL;
  final String currency;
  final List<List<Map<String, dynamic>>> tapData;
  final List<Map<String, dynamic>> supporters;
  final bool completed;
  final String category;
  final String startTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> likes;
  final int amount;

  ContestModal({
    required this.id,
    required this.productCode,
    required this.productId,
    required this.productName,
    required this.videoURL,
    required this.currency,
    required this.tapData,
    required this.supporters,
    required this.completed,
    required this.category,
    required this.startTime,
    required this.createdAt,
    required this.updatedAt,
    required this.likes,
    required this.amount,
  });

  factory ContestModal.fromJson(Map<String, dynamic> json) {
    return ContestModal(
      id: json['_id'],
      productCode: json['productCode'],
      productId: json['productId'],
      productName: json['productName'],
      videoURL: json['videoURL'],
      currency: json['currency'],
      tapData: List<List<Map<String, dynamic>>>.from(json['tapData']
          .map((data) => List<Map<String, dynamic>>.from(data.map((x) => x)))),
      supporters: List<Map<String, dynamic>>.from(json['supporters']),
      completed: json['completed'],
      category: json['category'],
      startTime: json['startTime'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      likes: List<String>.from(json['likes']),
      amount: json['amount'],
    );
  }
}

class Support {
  final String id;
  final String productCode;
  final String productId;
  final String productName;
  final String videoURL;
  final String currency;
  final int amount;
  final List<List<Map<String, dynamic>>>? tapData; // Make tapData nullable
  final List<Map<String, dynamic>> supporters;
  final bool completed;
  final String category;
  final String startTime;
  final DateTime startTime2;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<String> likes;

  Support({
    required this.id,
    required this.startTime2,
    required this.productCode,
    required this.productId,
    required this.productName,
    required this.videoURL,
    required this.currency,
    required this.amount,
    this.tapData, // Make tapData nullable
    required this.supporters,
    required this.completed,
    required this.category,
    required this.startTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.likes,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      id: json['contestId'],
      productCode: json['productCode'],
      productId: json['productId'],
      productName: json['productName'],
      videoURL: json['videoURL'],
      currency: json['currency'],
      amount: json['amount'],
      startTime2: DateTime.parse(json["startTime"]),
      tapData: json['tapData'] != null && json['tapData'] is List
          ? List<List<Map<String, dynamic>>>.from(json['tapData'].map((data) =>
              List<Map<String, dynamic>>.from(
                  data.map((item) => Map<String, dynamic>.from(item)))))
          : null,
      // Check if tapData is null
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

class MakharejTransaction {
  final String id;
  final String categoryId;
  final String categoryTitle;
  final bool isExpense;
  final DateTime createdTime;
  final double value;
  final String description;
  final String familyID;
  final String createdBy;

  MakharejTransaction({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.isExpense,
    required this.createdTime,
    required this.value,
    required this.description,
    required this.familyID,
    required this.createdBy,
  });

  factory MakharejTransaction.fromJson(Map<String, dynamic> json) {
    return MakharejTransaction(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      categoryTitle: json['categoryTitle'] as String,
      isExpense: json['isExpense'] as bool,
      createdTime: DateTime.parse(json['createdTime'] as String),
      value: (json['value'] as num).toDouble(),
      description: json['description'] as String,
      familyID: json['familyID'] as String,
      createdBy: json['createdBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'isExpense': isExpense,
      'createdTime': createdTime.toIso8601String(),
      'value': value,
      'description': description,
      'familyID': familyID,
    };
  }
}

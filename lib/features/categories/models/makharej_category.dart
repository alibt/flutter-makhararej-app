class MakharejCategory {
  late String id;
  final String title;
  final double? currentTotalValue;
  final double? monthlyTotalValuePrediction;
  final String? color;
  final String? iconName;
  final bool isIncome;
  final String familyID;
  final String createdBy;

  bool get isExpense => !isIncome;

  MakharejCategory(
      {required this.title,
      required this.id,
      required this.isIncome,
      required this.familyID,
      required this.createdBy,
      this.currentTotalValue,
      this.monthlyTotalValuePrediction,
      this.color,
      this.iconName});
//how should we handle exceptions here? what if data coming back from api
// is not valid as it may not have correct title field
  MakharejCategory.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        createdBy = json['createdBy'],
        familyID = json['familyID'],
        isIncome = json['isIncome'],
        currentTotalValue = json['currentTotalValue'],
        monthlyTotalValuePrediction = json['monthlyTotalValuePrediction'],
        color = json['color'],
        iconName = json['iconName'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['currentTotalValue'] = currentTotalValue;
    data['isIncome'] = isIncome;
    data['monthlyTotalValuePrediction'] = monthlyTotalValuePrediction;
    data['color'] = color;
    data['iconName'] = iconName;
    return data;
  }
}

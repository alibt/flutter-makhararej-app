class MakharejCategory {
  String id;
  String title;
  double? currentTotalValue;
  double? monthlyTotalValuePrediction;
  String? color;
  String? iconName;
  bool isIncome;
  bool get isExpense => !isIncome;

  MakharejCategory(
      {required this.title,
      required this.id,
      required this.isIncome,
      this.currentTotalValue,
      this.monthlyTotalValuePrediction,
      this.color,
      this.iconName});
//how should we handle exceptions here? what if data coming back from api
// is not valid as it may not have correct title field
  MakharejCategory.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        isIncome = json['isIncome'] {
    currentTotalValue = json['currentTotalValue'];
    monthlyTotalValuePrediction = json['monthlyTotalValuePrediction'];
    color = json['color'];
    iconName = json['iconName'];
  }

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

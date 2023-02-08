class ExpenseCategory {
  String id;
  String title;
  int? currentTotalValue;
  int? monthlyTotalValuePrediction;
  String? color;
  String? iconName;

  ExpenseCategory(
      {required this.title,
      required this.id,
      this.currentTotalValue,
      this.monthlyTotalValuePrediction,
      this.color,
      this.iconName});
//how should we handle exceptions here? what if data coming back from api
// is not valid as it may not have correct title field
  ExpenseCategory.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'] {
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
    data['monthlyTotalValuePrediction'] = monthlyTotalValuePrediction;
    data['color'] = color;
    data['iconName'] = iconName;
    return data;
  }
}

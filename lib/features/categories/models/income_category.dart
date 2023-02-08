//comparing predictions and actual expense is going to be available
// only for current month, so the [monthlyTotalValuePrediction] type
// will be int
class IncomeCategory {
  String id;
  String title;
  int? currentTotalValue;
  int? monthlyTotalValuePrediction;
  String? color;
  String? iconName;

  IncomeCategory(
      {required this.title,
      required this.id,
      this.currentTotalValue,
      this.monthlyTotalValuePrediction,
      this.color,
      this.iconName});

  IncomeCategory.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'] {
    currentTotalValue = json['currentTotalValue'];
    monthlyTotalValuePrediction = json['monthlyTotalValuePrediction'];
    color = json['color'];
    iconName = json['iconName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['currentTotalValue'] = currentTotalValue;
    data['monthlyTotalValuePrediction'] = monthlyTotalValuePrediction;
    data['color'] = color;
    data['iconName'] = iconName;
    return data;
  }
}

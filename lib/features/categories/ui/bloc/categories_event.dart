abstract class CategoryEvent {
  const CategoryEvent();
}

class AddCategoryEvent extends CategoryEvent {
  final String id;
  final String title;
  final String color;
  final int? monthlyPrediction;
  final String? icon;
  AddCategoryEvent({
    required this.id,
    required this.title,
    required this.color,
    this.monthlyPrediction,
    this.icon,
  });
}

class UpdateCategoryEvent extends CategoryEvent {}

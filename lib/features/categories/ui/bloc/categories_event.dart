import 'package:flutter/foundation.dart';
import 'package:makharej_app/features/categories/models/expence_category.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoryAddEvent extends CategoryEvent {
  final ExpenseCategory category;
  CategoryAddEvent({required this.category});
}

class CategoryUpdateEvent extends CategoryEvent {
  final Category category;
  const CategoryUpdateEvent(this.category);
}

class CategoryFetchListEvent extends CategoryEvent {}

class CategoryFetchDetailsEvent extends CategoryEvent {
  final String id;
  const CategoryFetchDetailsEvent(this.id);
}

class CategoryDeleteEvent extends CategoryEvent {
  final String id;
  const CategoryDeleteEvent(this.id);
}

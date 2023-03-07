import 'package:flutter/material.dart';
import 'package:makharej_app/features/categories/models/expence_category.dart';

@immutable
abstract class CategoryState {
  final List<ExpenseCategory> categories;

  const CategoryState(this.categories);
}

class CategoriesInitState extends CategoryState {
  const CategoriesInitState(super.categories);
}

class CategoriesLoadingState extends CategoryState {
  const CategoriesLoadingState(super.categories);
}

class CategoriesLoadedState extends CategoryState {
  const CategoriesLoadedState(List<ExpenseCategory> categories)
      : super(categories);
}

class CategoriesErrorState extends CategoryState {
  final String message;

  const CategoriesErrorState(List<ExpenseCategory> categories, this.message)
      : super(categories);
}

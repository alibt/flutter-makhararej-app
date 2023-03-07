import 'package:flutter/material.dart';
import 'package:makharej_app/features/categories/models/makharej_category.dart';

@immutable
abstract class CategoryState {
  final List<MakharejCategory> categories;

  const CategoryState(this.categories);
}

class CategoriesInitState extends CategoryState {
  const CategoriesInitState(super.categories);
}

class CategoriesLoadingState extends CategoryState {
  const CategoriesLoadingState(super.categories);
}

class CategoriesLoadedState extends CategoryState {
  const CategoriesLoadedState(List<MakharejCategory> categories)
      : super(categories);
}

class CategoriesErrorState extends CategoryState {
  final String message;

  const CategoriesErrorState(List<MakharejCategory> categories, this.message)
      : super(categories);
}

import 'package:flutter/foundation.dart';
import 'package:makharej_app/features/categories/models/makharej_category.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';

abstract class CategoryEvent {
  const CategoryEvent({required this.makharejUser});
  final MakharejUser makharejUser;
}

class CategoryAddEvent extends CategoryEvent {
  final MakharejCategory category;
  CategoryAddEvent({
    required this.category,
    required super.makharejUser,
  });
}

class CategoryUpdateEvent extends CategoryEvent {
  final Category category;
  const CategoryUpdateEvent({
    required super.makharejUser,
    required this.category,
  });
}

class CategoryFetchListEvent extends CategoryEvent {
  CategoryFetchListEvent({required super.makharejUser});
}

class CategoryFetchDetailsEvent extends CategoryEvent {
  final String id;
  const CategoryFetchDetailsEvent({
    required this.id,
    required super.makharejUser,
  });
}

class CategoryDeleteEvent extends CategoryEvent {
  final String id;
  const CategoryDeleteEvent({
    required this.id,
    required super.makharejUser,
  });
}

import 'package:flutter/material.dart';

import '../../../models/makharej_category.dart';
import 'category_card.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<MakharejCategory> categories;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CategoryCard(category: categories[index]);
          },
          childCount: categories.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0));
  }
}

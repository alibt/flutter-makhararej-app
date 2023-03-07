import 'package:flutter/material.dart';
import 'package:makharej_app/features/categories/models/makharej_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final MakharejCategory category;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(category.title),
          if (category.currentTotalValue != null &&
              category.monthlyTotalValuePrediction != null)
            ActualSlashPrediction(
                actual: category.currentTotalValue!,
                prediction: category.monthlyTotalValuePrediction!),
          Icon(category.isExpense ? Icons.arrow_upward : Icons.arrow_downward)
        ],
      ),
    );
  }
}

class ActualSlashPrediction extends StatelessWidget {
  const ActualSlashPrediction(
      {super.key, required this.actual, required this.prediction});
  final double actual;
  final double prediction;

  @override
  Widget build(BuildContext context) {
    return Text("$actual/$prediction");
  }
}

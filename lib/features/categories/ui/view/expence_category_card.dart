import 'package:flutter/material.dart';
import 'package:makharej_app/features/categories/models/expence_category.dart';

class ExpenceCategoryCard extends StatelessWidget {
  const ExpenceCategoryCard({super.key, required this.category});
  final ExpenseCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(category.title),
          if (category.currentTotalValue != null &&
              category.monthlyTotalValuePrediction != null)
            ActualSlashPrediction(
                actual: category.currentTotalValue!,
                prediction: category.monthlyTotalValuePrediction!)
        ],
      ),
    );
  }
}

class ActualSlashPrediction extends StatelessWidget {
  const ActualSlashPrediction(
      {super.key, required this.actual, required this.prediction});
  final int actual;
  final int prediction;

  @override
  Widget build(BuildContext context) {
    return Text("$actual/$prediction");
  }
}

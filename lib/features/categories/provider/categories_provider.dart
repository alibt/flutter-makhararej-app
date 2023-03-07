import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/constants/configs.dart';
import 'package:makharej_app/core/exceptions/network_exceptions.dart';
import 'package:makharej_app/core/mock_data/mock_categories_list.dart';
import 'package:makharej_app/features/authentication/provider/auth_provider.dart';
import 'package:makharej_app/features/categories/models/makharej_category.dart';

class CategoryProvider {
  final AuthProvider authService;

  CategoryProvider(this.authService);

  Future<void> waitTwoSeconds() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<Either<List<MakharejCategory>, Exception>> getCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mockCategories) {
      try {
        var categoriesList = <MakharejCategory>[];
        for (var category in mockCategoriesList) {
          categoriesList.add(MakharejCategory.fromJson(category));
        }
        return left(categoriesList);
      } catch (e) {
        return right(ConnectionException());
      }
    } else {
      //TODO implement fetching categories from BE
      throw UnimplementedError();
    }
  }

  Future<Either<String, Exception>> addCategory(
      MakharejCategory category) async {
    try {
      //TODO implement add category to DB - BE

      throw UnimplementedError();
    } catch (e) {
      return right(ConnectionException());
    }
  }
}

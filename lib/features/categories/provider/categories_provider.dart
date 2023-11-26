import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/constants/configs.dart';
import 'package:makharej_app/core/constants/firestore_collections_names.dart';
import 'package:makharej_app/core/mock_data/mock_categories_list.dart';
import 'package:makharej_app/features/authentication/provider/firebase_auth_provider.dart';
import 'package:makharej_app/features/categories/models/makharej_category.dart';

class CategoryProvider {
  final FirebaseAuthProvider authService;

  CategoryProvider(this.authService);

  Future<Either<List<MakharejCategory>, Exception>> getCategoriesByFamilyID(
      String familyID) async {
    if (mockCategories) {
      try {
        var categoriesList = <MakharejCategory>[];
        for (var category in mockCategoriesList) {
          categoriesList.add(
            MakharejCategory.fromJson(category),
          );
        }
        return left(categoriesList);
      } on Exception catch (e) {
        return right(e);
      }
    }
    try {
      final db = FirebaseFirestore.instance;
      final categoriesList = <MakharejCategory>[];
      await db
          .collection(
            CollectionNames.categories,
          )
          .where('familyID', isEqualTo: familyID)
          .get()
          .then(
        (categories) {
          for (var catDoc in categories.docs) {
            final categoryObj = MakharejCategory.fromJson(catDoc.data());
            categoryObj.id = catDoc.id;
            categoriesList.add(categoryObj);
          }
        },
      );
      return left(categoriesList);
    } on Exception catch (e) {
      return right(e);
    }
  }

  Future<Either<String, Exception>> addCategory(
      MakharejCategory category) async {
    try {
      final db = FirebaseFirestore.instance;
      final _ = await db.collection(CollectionNames.categories).add(
            category.toJson(),
          );

      return left("category successfully added");
    } on FirebaseException catch (e) {
      return right(e);
    } on Exception catch (e) {
      return right(e);
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:makharej_app/core/exceptions/network_exceptions.dart';
import 'package:makharej_app/features/categories/models/makharej_category.dart';
import 'package:makharej_app/features/categories/provider/categories_provider.dart';
import 'package:makharej_app/features/categories/ui/bloc/categories_event.dart';
import 'package:makharej_app/features/categories/ui/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryProvider categoryProvider;
  List<MakharejCategory> categories = [];
  CategoriesBloc(this.categoryProvider) : super(const CategoriesInitState([])) {
    on<CategoryFetchListEvent>(
        (event, emitter) => _onFetchCategoriesList(event, emitter));
    on<CategoryAddEvent>((event, emitter) => _onAddCategory(event, emitter));
  }

  void _onFetchCategoriesList(
    CategoryFetchListEvent event,
    Emitter<CategoryState> emitter,
  ) async {
    emitter(CategoriesLoadingState(categories));

    var result = await categoryProvider.getCategories("");
    result.fold(
        (categoriesList) =>
            _onSuccesfullyFetchedCategoriesList(categoriesList, emitter),
        (exception) => emitter(
              CategoriesErrorState(categories, "Error"),
            ));
  }

  void _onSuccesfullyFetchedCategoriesList(
      List<MakharejCategory> list, Emitter<CategoryState> emitter) {
    categories = list;
    emitter(CategoriesLoadedState(list));
  }

  void _onAddCategory(
      CategoryAddEvent categoryAddEvent, Emitter<CategoryState> emitter) async {
    emitter(CategoriesLoadingState(categories));

    var result = await categoryProvider.addCategory(categoryAddEvent.category);
    result.fold(
      (catID) => _onSuccussfullyAddedCategory(
          categoryAddEvent.category, emitter, catID),
      (exception) => _failedToAddCategory(exception, emitter),
    );
  }

  void _onSuccussfullyAddedCategory(
      MakharejCategory category, Emitter<CategoryState> emitter, String catID) {
    category.id = catID;
    categories.add(category);
    emitter(CategoriesLoadedState(categories));
  }

  void _failedToAddCategory(
      Exception exception, Emitter<CategoryState> emitter) {
    if (exception is ConnectionException) {
      emitter(CategoriesErrorState(categories, "Adding Failed"));
      return;
    }
    emitter(CategoriesErrorState(categories, "Unknown Error"));
  }
}

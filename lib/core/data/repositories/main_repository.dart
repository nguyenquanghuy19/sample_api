import 'package:testproject/core/data/local/dao/category_dao.dart';
import 'package:testproject/core/data/models/category_model.dart';
import 'package:testproject/core/data/remote/services/main_service.dart';

class MainRepository {
  final MainService _mainService = MainService();
  final CategoryDao _categoryDao = CategoryDao();

  Future<DataCategoriesResponse?> getListCategory() async {
    try {
      return await _mainService.getListCategory();
    } on Exception {
      rethrow;
    }
  }

  void saveItemCategoryToDB(List<CategoryModel> categories) {
    for (int i = 0; i < categories.length; i++) {
      _categoryDao.insert(
        id: categories[i].id,
        name: categories[i].name,
        selected: categories[i].isSelected ? 1 : 0,
      );
    }
  }

  Future<List<CategoryModel>?> getListCategoryFromDB() async {
    List<CategoryModel>? categoryLocal = [];
    final listCategoryDB = await _categoryDao.getCategories();
    if (listCategoryDB == null) return null;
    categoryLocal = listCategoryDB
        .map(
          (obj) => CategoryModel(
            id: obj.id!,
            name: obj.name!,
            isSelected: obj.selected == 1 ? true : false,
          ),
        )
        .toList();

    return categoryLocal;
  }
}

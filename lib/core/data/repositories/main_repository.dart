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

  Future<void> saveItemCategory({required String id, required String name, bool isSelected = false}) async {
    await _categoryDao.insert(id: id, name: name, selected: isSelected ? 1 :0);
  }

  void saveItemCategoryObject(List<CategoryModel> categories)  {
    for(int i = 0 ; i < categories.length; i++){
      _categoryDao.insert(id: categories[i].id, name: categories[i].name, selected: categories[i].isSelected ? 1 : 0);
    }
  }
}

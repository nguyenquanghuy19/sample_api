import 'package:testproject/core/data/models/category_model.dart';
import 'package:testproject/core/data/remote/services/main_service.dart';

class MainRepository {
  final MainService _mainService = MainService();

  Future<DataCategoriesResponse?> getListCategory() async {
    try {
      return await _mainService.getListCategory();
    } on Exception {
      rethrow;
    }
  }
}

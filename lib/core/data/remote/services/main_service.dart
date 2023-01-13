import 'package:testproject/core/constants/api_end_point.dart';
import 'package:testproject/core/data/models/category_model.dart';
import 'package:testproject/core/data/remote/services/base_service.dart';

class MainService extends BaseService {
  Future<DataCategoriesResponse?> getListCategory() async {
    return await get(
      ApiEndPointConstants.listCategory,
      mapper: (json) =>
          DataCategoriesResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}

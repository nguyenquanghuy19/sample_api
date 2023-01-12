import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class FlashCardService extends BaseService {
  Future<DataResponseFlashCardModel?> getFlashCard({
    int? id,
  }) async {
    try {
      return await get(
        "${ApiEndPointConstants.getDetailFlashCard}?Id=$id",
        mapper: (json) =>
            DataResponseFlashCardModel.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }
}

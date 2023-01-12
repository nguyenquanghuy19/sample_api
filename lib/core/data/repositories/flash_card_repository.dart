import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/core/data/remote/services/flash_card_service.dart';

class FlashCardRepository {
  final FlashCardService _flashCardService = FlashCardService();

  Future<DataResponseFlashCardModel?> getFlashCard({
    int? id,
  }) async {
    try {
      return await _flashCardService.getFlashCard(id: id);
    } on Exception {
      rethrow;
    }
  }
}

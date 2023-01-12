import 'package:dio/dio.dart';
import 'package:elearning/core/data/remote/services/media_service.dart';

class MediaRepository {
  final MediaService _mediaService = MediaService();

  Future<Response> getLmsFeatureImage(String fileName) async {
    try {
      return await _mediaService.getLmsFeatureImage(fileName);
    } on Exception {
      rethrow;
    }
  }
}
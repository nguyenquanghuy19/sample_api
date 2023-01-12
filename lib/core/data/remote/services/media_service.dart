import 'package:dio/dio.dart';
import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class MediaService extends BaseService {
  Future<Response> getLmsFeatureImage(String fileName) async {
    try {
      return await getImage(
        ApiEndPointConstants.getLmsFeatureImage,
        param: "?fileName=$fileName&model=1",
      );
    } on Exception {
      rethrow;
    }
  }
}

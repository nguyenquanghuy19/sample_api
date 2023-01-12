import 'package:elearning/core/data/models/software_information_model.dart';
import 'package:elearning/core/data/remote/services/software_information_service.dart';

class SoftwareInformationRepository {
  final SoftwareInformationService _softwareInformationService =
      SoftwareInformationService();

  Future<List<SoftwareInformationModel>> getAllListLicense() async {
    try {
      return await _softwareInformationService.getAllListLicense();
    } on Exception {
      rethrow;
    }
  }
}

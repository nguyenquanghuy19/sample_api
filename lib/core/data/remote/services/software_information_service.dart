import 'package:elearning/core/data/models/software_information_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';
import 'package:elearning/core/mock_datas/mock_software_information_data.dart';

class SoftwareInformationService extends BaseService {
  Future<List<SoftwareInformationModel>> getAllListLicense() async {
    await Future.delayed(const Duration(milliseconds: 50));

    return MockSoftwareInformationData.license;
  }
}

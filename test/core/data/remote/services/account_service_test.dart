import 'package:dio/dio.dart';
import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';

import 'base_service.dart';

class AccountServiceTest {
  final BaseService baseService;

  AccountServiceTest({required this.baseService});

  Future<DataProfileModel?> getProfile() async {
    try {
      return await baseService.get(
        ApiEndPointConstants.getProfile,
        mapper: (json) =>
            DataProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> updateProfile(DataToUpdate data) async {
    final body = <String, dynamic>{};
    body['Avatar'] = data.avatar != null
        ? await MultipartFile.fromFile(data.avatar!.path)
        : '${data.avatar}';
    body['DisplayName'] = data.displayName;
    body['LastName'] = data.lastName;
    body['FirstName'] = data.firstName;
    body['DateOfBirth'] = data.dateOfBirth;
    body['Gender'] = data.gender;
    body['PhoneNumber'] = data.phoneNumber;
    body['Address'] = data.address;
    body['City'] = data.city;
    body['Country'] = data.country;

    return await baseService.patch(
      ApiEndPointConstants.updateProfile,
      body: FormData.fromMap(body),
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> updatePassword(
    String currentPassword,
    String newPassword,
    String newConfirmPassword,
  ) async {
    final body =
        '{"currentPassword": "$currentPassword", "NewPassword": "$newPassword", "NewPasswordConfirmation": "$newConfirmPassword"}';

    return await baseService.put(
      ApiEndPointConstants.updatePassword,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}

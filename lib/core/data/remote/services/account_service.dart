import 'package:dio/dio.dart';
import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';
import 'package:intl/intl.dart';

class AccountService extends BaseService {
  Future<DataProfileModel?> getProfile() async {
    return await get(
      ApiEndPointConstants.getProfile,
      mapper: (json) => DataProfileModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> updateProfile(DataToUpdate data) async {
    final body = <String, dynamic>{};
    body['AvatarFile'] = data.avatar != null
        ? await MultipartFile.fromFile(data.avatar!.path)
        : null;
    body['DisplayName'] = data.displayName;
    body['LastName'] = data.lastName;
    body['FirstName'] = data.firstName;
    body['DateOfBirth'] = data.dateOfBirth != null
        ? DateFormat('yyyy-MM-dd').format(data.dateOfBirth!)
        : null;
    body['Gender'] = data.gender;
    body['PhoneNumber'] = data.phoneNumber;
    body['Address'] = data.address;
    body['City'] = data.city;
    body['Country'] = data.country;

    return await patch(
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

    return await put(
      ApiEndPointConstants.updatePassword,
      body: body,
      mapper: (json) => DataResponseModel.fromJson(
        json as Map<String, dynamic>,
      ),
    );
  }

  Future<Response> getAvatar(String? fileName) async {
    try {
      return await getImage(
        ApiEndPointConstants.getAvatar,
        param: "?fileName=$fileName",
      );
    } on Exception {
      rethrow;
    }
  }
}

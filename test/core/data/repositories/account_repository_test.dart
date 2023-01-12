import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/account_service.dart';

class AccountRepositoryTest {
  final AccountService accountService;

  AccountRepositoryTest({required this.accountService});

  Future<DataProfileModel?> getProfile() async {
    try {
      return await accountService.getProfile();
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> updateProfile(DataToUpdate data) async {
    try {
      return await accountService.updateProfile(data);
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> updatePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      return await accountService.updatePassword(
        currentPassword,
        newPassword,
        newPasswordConfirmation,
      );
    } on Exception {
      rethrow;
    }
  }
}

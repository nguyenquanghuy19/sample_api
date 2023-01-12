import 'package:dio/dio.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/account_service.dart';

class AccountRepository {
  final AccountService _accountService = AccountService();

  Future<DataProfileModel?> getProfile() async {
    try {
      return await _accountService.getProfile();
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> updateProfile(DataToUpdate data) async {
    try {
      return await _accountService.updateProfile(data);
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
      return await _accountService.updatePassword(
        currentPassword,
        newPassword,
        newPasswordConfirmation,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getAvatar(String? fileName) async {
    try {
      return await _accountService.getAvatar(fileName);
    } on Exception {
      rethrow;
    }
  }
}

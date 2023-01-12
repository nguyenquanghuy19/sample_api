import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel {
  final AccountRepository accountRepository;

  ProfileViewModel({required this.accountRepository});

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    await getProfile();
  }

  Future<DataProfileModel?> getProfile({bool isFirstLoad = true}) async {
    try {
      return await accountRepository.getProfile();
    } on Exception {
      rethrow;
    }
  }
}

import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';

class UpdateProfileViewModel extends BaseViewModel {
  final AccountRepository accountRepository;

  UpdateProfileViewModel({required this.accountRepository});

  Future<DataResponseModel?> updateProfile(DataToUpdate dataToUpdate) async {
    try {
      return await accountRepository.updateProfile(dataToUpdate);
    } on Exception {
      rethrow;
    }
  }
}

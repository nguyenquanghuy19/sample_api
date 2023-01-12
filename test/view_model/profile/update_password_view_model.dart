import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';

class UpdatePasswordViewModel extends BaseViewModel {
  final AccountRepository accountRepository;

  UpdatePasswordViewModel({required this.accountRepository});

  Future<DataResponseModel?> updatePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      final res = await accountRepository.updatePassword(
        currentPassword,
        newPassword,
        newPasswordConfirmation,
      );

      return res;
    } on Exception {
      rethrow;
    }
  }
}

import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/account_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_model_test.mocks.dart';
import 'view_model/profile/update_password_view_model.dart';

@GenerateMocks([AccountService])
void main() {
  MockAccountRepository mockAccountRepository = MockAccountRepository();
  late UpdatePasswordViewModel changePasswordViewModel;
  setUpAll(
    () {
      changePasswordViewModel =
          UpdatePasswordViewModel(accountRepository: mockAccountRepository);
    },
  );

  test(
    "Test change password can't null...",
    () async {
      when(mockAccountRepository.updatePassword(any, any, any)).thenAnswer(
        (inv) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your password successfully!',
          ),
        ),
      );
      expect(
        await changePasswordViewModel.updatePassword(
          '12345678@Ab',
          'newPassword',
          'newPassword',
        ),
        isA<DataResponseModel>(),
      );
    },
  );

  test(
    "Test change password can null...",
    () async {
      when(
        mockAccountRepository.updatePassword(any, any, any),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await changePasswordViewModel.updatePassword(
          '12345678@Ab',
          'newPassword',
          'newPassword',
        ),
        isA<DataResponseModel?>(),
      );
    },
  );

  test(
    'Test change password (wrong current password)',
    () async {
      when(
        mockAccountRepository.updatePassword(any, any, any),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(status: false, message: 'Incorrect password.'),
        ),
      );
      expect(
        await changePasswordViewModel.updatePassword(
          'abc',
          'newPassword',
          'newPassword',
        ),
        isA<DataResponseModel>(),
      );
    },
  );

  test(
    'Test change password (newPasswordConfirmation not equal newPassword)',
    () async {
      when(
        mockAccountRepository.updatePassword(any, any, any),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await changePasswordViewModel
            .updatePassword(
              '12345678@Ab',
              'newPassword',
              'abide',
            )
            .then((value) => Exception()),
        isA<Exception>(),
      );
    },
  );

  test(
    'Test change password has exception...',
    () async {
      when(
        mockAccountRepository.updatePassword(any, any, any),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await changePasswordViewModel
            .updatePassword('12345678@Ab', 'newPassword', 'newPassword')
            .then(
              (value) => Exception(),
            ),
        isA<Exception>(),
      );
    },
  );
}

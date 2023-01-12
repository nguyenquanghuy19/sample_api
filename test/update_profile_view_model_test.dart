import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_model_test.mocks.dart';
import 'view_model/profile/update_profile_view_model.dart';

@GenerateMocks([AccountRepository])
void main() {
  MockAccountRepository mockAccountRepository = MockAccountRepository();
  late UpdateProfileViewModel updateProfileViewModel;
  setUpAll(() {
    updateProfileViewModel =
        UpdateProfileViewModel(accountRepository: mockAccountRepository);
  });

  test(
    "Test update profile can't null...",
    () async {
      final DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockAccountRepository.updateProfile(any),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your profile infor successfully!',
          ),
        ),
      );
      expect(
        await updateProfileViewModel.updateProfile(dataToUpdate),
        isA<DataResponseModel>(),
      );
    },
  );

  test(
    "Test update profile can null...",
    () async {
      final DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockAccountRepository.updateProfile(any),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await updateProfileViewModel.updateProfile(dataToUpdate),
        isA<DataResponseModel?>(),
      );
    },
  );

  test(
    'Test update profile has exception ...',
    () async {
      final DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockAccountRepository.updateProfile(any),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await updateProfileViewModel.updateProfile(dataToUpdate).then(
              (value) => Exception(),
            ),
        isA<Exception>(),
      );
    },
  );
}

import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_model_test.mocks.dart';
import 'view_model/profile/profile_view_model.dart';

@GenerateMocks([AccountRepository])
void main() {
  MockAccountRepository mockAccountRepository = MockAccountRepository();
  late ProfileViewModel fakeProfileViewModel;

  setUpAll(
    () {
      fakeProfileViewModel =
          ProfileViewModel(accountRepository: mockAccountRepository);
    },
  );

  test(
    "Test get profile can't null...",
    () async {
      when(
        mockAccountRepository.getProfile(),
      ).thenAnswer(
        (inv) => Future.value(
          DataProfileModel(
            status: true,
            message: 'Get user infor successfully!',
            data: ProfileModel(),
            total: 0,
          ),
        ),
      );
      expect(
        await fakeProfileViewModel.getProfile(),
        isA<DataProfileModel>(),
      );
    },
  );

  test(
    "Test get profile can null...",
    () async {
      when(
        mockAccountRepository.getProfile(),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await fakeProfileViewModel.getProfile(),
        isA<DataProfileModel?>(),
      );
    },
  );

  test(
    'Test get profile exception ...',
    () async {
      when(
        mockAccountRepository.getProfile(),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await fakeProfileViewModel.getProfile().then(
              (value) => Exception(),
            ),
        isA<Exception>(),
      );
    },
  );
}

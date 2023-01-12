import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/account_service.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'account_repository_test.mocks.dart';
import 'core/data/repositories/account_repository_test.dart';

@GenerateMocks([AccountService])
void main() {
  MockAccountService mockAccountService = MockAccountService();
  late AccountRepositoryTest accountRepositoryTest;
  setUpAll(
    () {
      FlavorConfig(
        flavor: Flavor.develop,
        color: Colors.redAccent,
        // それ以外のAPIの接続先
        baseApiUrl: "http://10.20.22.42:1505/api/v1",
        versionAPI: "",
        othersVersionApi: {},
        supportMailAddress: "",
        saveRidingLogApiUrl: "",
        saveRidingLogVersionApi: "",
        hasMockAPI: false,
      );
      accountRepositoryTest =
          AccountRepositoryTest(accountService: mockAccountService);
    },
  );

  test("Test get profile can't null ...", () async {
    when(
      mockAccountService.getProfile(),
    ).thenAnswer(
      (realInvocation) => Future.value(
        DataProfileModel(
          status: true,
          message: 'Get user infor successfully!',
          data: ProfileModel(),
          total: 0,
        ),
      ),
    );
    expect(
      await accountRepositoryTest.getProfile(),
      isA<DataProfileModel>(),
    );
  });

  test(
    "Test get profile can null ...",
    () async {
      when(
        mockAccountService.getProfile(),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await accountRepositoryTest.getProfile(),
        isA<DataProfileModel?>(),
      );
    },
  );

  test('Test get profile has exception ...', () async {
    when(
      mockAccountService.getProfile(),
    ).thenAnswer((inv) => Future.value());
    expect(
      await accountRepositoryTest.getProfile().then(
            (value) => Exception(),
          ),
      isA<Exception>(),
    );
  });

  test("Test update profile can't null...", () async {
    DataToUpdate dataToUpdate = DataToUpdate();
    when(
      mockAccountService.updateProfile(any),
    ).thenAnswer(
      (inv) => Future.value(
        DataResponseModel(
          status: true,
          message: 'Update your profile infor successfully!',
        ),
      ),
    );
    expect(
      await accountRepositoryTest.updateProfile(dataToUpdate),
      isA<DataResponseModel>(),
    );
  });

  test("Test update profile can null...", () async {
    DataToUpdate dataToUpdate = DataToUpdate();
    when(
      mockAccountService.updateProfile(any),
    ).thenAnswer(
      (inv) => Future.value(),
    );
    expect(
      await accountRepositoryTest.updateProfile(dataToUpdate),
      isA<DataResponseModel?>(),
    );
  });

  test(
    'Test update profile has exception ...',
    () async {
      DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockAccountService.updateProfile(any),
      ).thenAnswer(
        (inv) => Future.value(),
      );
      expect(
        await accountRepositoryTest.updateProfile(dataToUpdate).then(
              (value) => Exception(),
            ),
        isA<Exception>(),
      );
    },
  );

  test(
    "Test change password can't null...",
    () async {
      when(
        mockAccountService.updatePassword(any, any, any),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your password successfully!',
          ),
        ),
      );
      expect(
        await accountRepositoryTest.updatePassword(
          '12345678@Ab',
          '12345678@ABc',
          '12345678@ABc',
        ),
        isA<DataResponseModel>(),
      );
    },
  );

  test(
    'Test change password (wrong current password)...',
    () async {
      when(
        mockAccountService.updatePassword(any, any, any),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(status: false, message: 'Incorrect password.'),
        ),
      );
      expect(
        await accountRepositoryTest.updatePassword(
          'abc',
          '12345678@ABc',
          '12345678@ABc',
        ),
        isA<DataResponseModel>(),
      );
    },
  );

  test(
    'Test change password (newPasswordConfirmation not equal newPassword)...',
    () async {
      when(
        mockAccountService.updatePassword(any, any, any),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await accountRepositoryTest
            .updatePassword('12345678@Ab', '12345678@ABc', 'cacao')
            .then((value) => Exception()),
        isA<Exception>(),
      );
    },
  );

  test(
    'Test change password has exception ...',
    () async {
      when(
        mockAccountService.updatePassword(any, any, any),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await accountRepositoryTest
            .updatePassword('12345678@Ab', '12345678@ABc', 'cacao')
            .then((value) => Exception()),
        isA<Exception>(),
      );
    },
  );
}

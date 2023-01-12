import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'account_service_test.mocks.dart';
import 'core/data/remote/services/account_service_test.dart';
import 'core/data/remote/services/base_service.dart';

@GenerateNiceMocks([MockSpec<BaseService>()])
void main() {
  MockBaseService mockBaseService = MockBaseService();
  late AccountServiceTest accountServiceTest;
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
      accountServiceTest = AccountServiceTest(baseService: mockBaseService);
    },
  );

  test(
    "Test get profile service can't null ...",
    () async {
      when(
        mockBaseService.get(
          any,
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (inv) async => Future.value(
          DataProfileModel(
            status: true,
            message: 'Get user infor successfully!',
            data: ProfileModel(),
            total: 0,
          ),
        ),
      );
      expect(
        await accountServiceTest.getProfile().then((value) => DataProfileModel),
        DataProfileModel,
      );
    },
  );

  test(
    "Test get profile service can null ...",
    () async {
      when(
        mockBaseService.get(
          any,
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (inv) async => Future.value(
          DataProfileModel(
            status: true,
            message: 'Get user infor successfully!',
            data: ProfileModel(),
            total: 0,
          ),
        ),
      );
      expect(
        await accountServiceTest.getProfile(),
        isA<DataProfileModel?>(),
      );
    },
  );

  test(
    'Test get profile service has exception...',
    () async {
      when(
        mockBaseService.get(
          any,
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (inv) async => Future.value(),
      );
      expect(
        await accountServiceTest.getProfile().then(
              (value) => Exception(),
            ),
        isA<Exception>(),
      );
    },
  );

  test(
    "Test update profile can't null ...",
    () async {
      DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockBaseService.patch(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (inv) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your profile infor successfully!',
          ),
        ),
      );
      expect(
        await accountServiceTest
            .updateProfile(dataToUpdate)
            .then((value) => DataResponseModel),
        DataResponseModel,
      );
    },
  );

  test(
    "Test update profile can null ...",
    () async {
      DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockBaseService.patch(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (inv) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your profile infor successfully!',
          ),
        ),
      );
      expect(
        await accountServiceTest.updateProfile(dataToUpdate),
        isA<DataResponseModel?>(),
      );
    },
  );

  test(
    'Test update profile has exception ...',
    () async {
      DataToUpdate dataToUpdate = DataToUpdate();
      when(
        mockBaseService.patch(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (inv) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your profile infor successfully!',
          ),
        ),
      );
      expect(
        await accountServiceTest.updateProfile(dataToUpdate).then(
              (value) => Exception(),
            ),
        isA<Exception>(),
      );
    },
  );

  test(
    "Test change password can't null ...",
    () async {
      when(
        mockBaseService.put(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your password successfully!',
          ),
        ),
      );
      expect(
        await accountServiceTest
            .updatePassword('12345678@AB', 'newPassword', 'newPassword')
            .then((value) => DataResponseModel),
        DataResponseModel,
      );
    },
  );

  test(
    "Test change password can null ...",
    () async {
      when(
        mockBaseService.put(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(
            status: true,
            message: 'Update your password successfully!',
          ),
        ),
      );
      expect(
        await accountServiceTest.updatePassword(
          '12345678@AB',
          'newPassword',
          'newPassword',
        ),
        isA<DataResponseModel?>(),
      );
    },
  );

  test(
    'Test change password (wrong current password) ...',
    () async {
      when(
        mockBaseService.put(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(
          DataResponseModel(status: false, message: 'Incorrect password.'),
        ),
      );
      expect(
        await accountServiceTest
            .updatePassword('abc', 'newPassword', 'newPassword')
            .then((value) => DataResponseModel),
        DataResponseModel,
      );
    },
  );

  test(
    'Test change password (newPasswordConfirmation not equal newPassword) ...',
    () async {
      when(
        mockBaseService.put(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await accountServiceTest
            .updatePassword('12345678@AB', 'newPassword', 'newPassword')
            .then((value) => Exception()),
        isA<Exception>(),
      );
    },
  );

  test(
    'Test change password has exception ...',
    () async {
      when(
        mockBaseService.put(
          any,
          body: Object(),
          mapper: (json) => Object(),
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(),
      );
      expect(
        await accountServiceTest
            .updatePassword('12345678@AB', 'newPassword', 'newPassword')
            .then((value) => Exception()),
        isA<Exception>(),
      );
    },
  );
}

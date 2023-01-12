import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_service_test.mocks.dart';
import 'core/data/mock_datas/mock_data_auth_test.dart';
import 'core/data/remote/services/auth_service_test.dart';
import 'core/data/remote/services/base_service.dart';

@GenerateNiceMocks([MockSpec<BaseService>()])
void main() {
  MockBaseService mockAuthService = MockBaseService();
  late AuthService authServiceTest;

  setUpAll(() {
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
    authServiceTest = AuthService(baseService: mockAuthService);
  });

  /// GROUP TEST CASE API AUTH SERVICE
  group(
    MockDataAuthTest.groupTestAuthServiceTitle,
    () {
      test(
        MockDataAuthTest.signInTitleNotNull,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.userModel,
            ),
          );
          expect(
            await authServiceTest
                .signIn(
                  MockDataAuthTest.email,
                  MockDataAuthTest.password,
                )
                .then((_) => UserModel),
            UserModel,
          );
        },
      );
      test(
        MockDataAuthTest.signInTitleCanNull,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authServiceTest.signIn(
              MockDataAuthTest.email,
              MockDataAuthTest.password,
            ),
            isA<UserModel?>(),
          );
        },
      );
      test(
        MockDataAuthTest.signInTitleFailed,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authServiceTest
                .signIn(
                  MockDataAuthTest.email,
                  MockDataAuthTest.password,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataAuthTest.signUpTitleNotNull,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.dataResponseModel,
            ),
          );
          expect(
            await authServiceTest
                .signUp(
                  MockDataAuthTest.email,
                  MockDataAuthTest.password,
                  MockDataAuthTest.password,
                )
                .then((_) => DataResponseModel),
            DataResponseModel,
          );
        },
      );
      test(
        MockDataAuthTest.signUpTitleCanNull,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authServiceTest.signUp(
              MockDataAuthTest.email,
              MockDataAuthTest.password,
              MockDataAuthTest.password,
            ),
            isA<DataResponseModel?>(),
          );
        },
      );
      test(
        MockDataAuthTest.signUpTitleFailed,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authServiceTest
                .signUp(
                  MockDataAuthTest.email,
                  MockDataAuthTest.password,
                  MockDataAuthTest.password,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
      test(
        MockDataAuthTest.forgotPasswordTitleNotNull,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (inv) => Future.value(
              MockDataAuthTest.dataResponseModel,
            ),
          );
          expect(
            await authServiceTest
                .onGetNewPassword(
                  MockDataAuthTest.email,
                )
                .then((_) => DataResponseModel),
            DataResponseModel,
          );
        },
      );
      test(
        MockDataAuthTest.forgotPasswordTitleCanNull,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authServiceTest.onGetNewPassword(
              MockDataAuthTest.email,
            ),
            isA<DataResponseModel?>(),
          );
        },
      );
      test(
        MockDataAuthTest.forgotPasswordFailed,
        () async {
          when(
            mockAuthService.post(any, mapper: (json) => Object()),
          ).thenAnswer(
            (inv) => Future.value(),
          );
          expect(
            await authServiceTest
                .onGetNewPassword(
                  MockDataAuthTest.email,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
    },
  );
}

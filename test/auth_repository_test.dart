import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repository_test.mocks.dart';
import 'core/data/mock_datas/mock_data_auth_test.dart';
import 'core/data/remote/services/auth_service_test.dart';
import 'core/data/repositories/auth_repository_test.dart';

@GenerateMocks([AuthService])
void main() {
  MockAuthService mockAuthService = MockAuthService();
  late AuthRepository authRepository;

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
    authRepository = AuthRepository(authService: mockAuthService);
  });

  /// GROUP TEST CASE API AUTH REPOSITORY
  group(
    MockDataAuthTest.groupTestAuthRepositoryTitle,
    () {
      test(
        MockDataAuthTest.signInTitleNotNull,
        () async {
          when(
            mockAuthService.signIn(any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.userModel,
            ),
          );
          expect(
            await authRepository.signIn(
              MockDataAuthTest.email,
              MockDataAuthTest.password,
            ),
            isA<UserModel>(),
          );
        },
      );
      test(
        MockDataAuthTest.signInTitleCanNull,
        () async {
          when(
            mockAuthService.signIn(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authRepository.signIn(
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
            mockAuthService.signIn(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authRepository
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
            mockAuthService.signUp(any, any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.dataResponseModel,
            ),
          );
          expect(
            await authRepository.signUp(
              MockDataAuthTest.email,
              MockDataAuthTest.password,
              MockDataAuthTest.password,
            ),
            isA<DataResponseModel>(),
          );
        },
      );
      test(
        MockDataAuthTest.signUpTitleCanNull,
        () async {
          when(
            mockAuthService.signUp(any, any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authRepository.signUp(
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
            mockAuthService.signUp(any, any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authRepository
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
            mockAuthService.onGetNewPassword(any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.dataResponseModel,
            ),
          );
          expect(
            await authRepository.onGetNewPassword(
              MockDataAuthTest.email,
            ),
            isA<DataResponseModel>(),
          );
        },
      );
      test(
        MockDataAuthTest.forgotPasswordTitleCanNull,
        () async {
          when(
            mockAuthService.onGetNewPassword(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authRepository.onGetNewPassword(
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
            mockAuthService.onGetNewPassword(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await authRepository
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

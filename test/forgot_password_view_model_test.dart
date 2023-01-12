import 'package:elearning/core/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'core/data/mock_datas/mock_data_auth_test.dart';
import 'core/data/repositories/auth_repository_test.dart';
import 'forgot_password_view_model_test.mocks.dart';
import 'view_model/auth/forgot_view_model.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository mockAuthRepository = MockAuthRepository();
  late ForgotPasswordViewModel forgotPasswordViewModel;

  setUp(
    () {
      forgotPasswordViewModel =
          ForgotPasswordViewModel(authRepository: mockAuthRepository);
    },
  );

  /// GROUP TEST CASE API FORGOT PASSWORD VIEW MODEL
  group(
    MockDataAuthTest.groupTestForgotPasswordViewModelTitle,
    () {
      test(
        MockDataAuthTest.forgotPasswordTitleNotNull,
        () async {
          when(
            mockAuthRepository.onGetNewPassword(any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.dataResponseModel,
            ),
          );
          expect(
            await forgotPasswordViewModel.onForgotPassword(
              email: MockDataAuthTest.email,
            ),
            isA<DataResponseModel>(),
          );
        },
      );
      test(
        MockDataAuthTest.forgotPasswordTitleCanNull,
        () async {
          when(
            mockAuthRepository.onGetNewPassword(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forgotPasswordViewModel.onForgotPassword(
              email: MockDataAuthTest.email,
            ),
            isA<DataResponseModel?>(),
          );
        },
      );
      test(
        MockDataAuthTest.forgotPasswordFailed,
        () async {
          when(
            mockAuthRepository.onGetNewPassword(any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await forgotPasswordViewModel
                .onForgotPassword(
                  email: MockDataAuthTest.email,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
    },
  );
}

import 'package:elearning/core/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'core/data/mock_datas/mock_data_auth_test.dart';
import 'core/data/repositories/auth_repository_test.dart';
import 'sign_up_view_model_test.mocks.dart';
import 'view_model/auth/sign_up_view_model.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository authRepository = MockAuthRepository();
  late SignUpViewModel signUpViewModel;

  setUp(
    () {
      signUpViewModel = SignUpViewModel(authRepository: authRepository);
    },
  );

  /// GROUP TEST CASE API SIGN UP VIEW MODEL
  group(
    MockDataAuthTest.groupTestSignUpViewModelTitle,
    () {
      test(
        MockDataAuthTest.signUpTitleNotNull,
        () async {
          when(
            authRepository.signUp(any, any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.dataResponseModel,
            ),
          );
          expect(
            await signUpViewModel.onSignUp(
              email: MockDataAuthTest.email,
              password: MockDataAuthTest.password,
              confirmPassword: MockDataAuthTest.password,
            ),
            isA<DataResponseModel>(),
          );
        },
      );
      test(
        MockDataAuthTest.signUpTitleCanNull,
        () async {
          when(
            authRepository.signUp(any, any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await signUpViewModel.onSignUp(
              email: MockDataAuthTest.email,
              password: MockDataAuthTest.password,
              confirmPassword: MockDataAuthTest.password,
            ),
            isA<DataResponseModel?>(),
          );
        },
      );
      test(
        MockDataAuthTest.signUpTitleFailed,
        () async {
          when(
            authRepository.signUp(any, any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await signUpViewModel
                .onSignUp(
                  email: MockDataAuthTest.email,
                  password: MockDataAuthTest.password,
                  confirmPassword: MockDataAuthTest.password,
                )
                .then((_) => Exception()),
            isA<Exception>(),
          );
        },
      );
    },
  );
}

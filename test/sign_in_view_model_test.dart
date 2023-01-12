import 'package:elearning/core/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'core/data/mock_datas/mock_data_auth_test.dart';
import 'core/data/repositories/auth_repository_test.dart';
import 'sign_in_view_model_test.mocks.dart';
import 'view_model/auth/sign_in_view_model.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository mockAuthRepository = MockAuthRepository();
  late SignInViewModel signInViewModel;

  setUp(
    () {
      signInViewModel = SignInViewModel(authRepository: mockAuthRepository);
    },
  );

  /// GROUP TEST CASE API SIGN IN VIEW MODEL
  group(
    MockDataAuthTest.groupTestSignInViewModelTitle,
    () {
      test(
        MockDataAuthTest.signInTitleNotNull,
        () async {
          when(
            mockAuthRepository.signIn(any, any),
          ).thenAnswer(
            (_) => Future.value(
              MockDataAuthTest.userModel,
            ),
          );
          expect(
            await signInViewModel.onSignIn(
              email: MockDataAuthTest.email,
              password: MockDataAuthTest.password,
            ),
            isA<UserModel>(),
          );
        },
      );
      test(
        MockDataAuthTest.signInTitleCanNull,
        () async {
          when(
            mockAuthRepository.signIn(any, any),
          ).thenAnswer(
            (_) => Future.value(),
          );
          expect(
            await signInViewModel.onSignIn(
              email: MockDataAuthTest.email,
              password: MockDataAuthTest.password,
            ),
            isA<UserModel?>(),
          );
        },
      );
      test(MockDataAuthTest.signInTitleFailed, () async {
        when(
          mockAuthRepository.signIn(any, any),
        ).thenAnswer(
          (_) => Future.value(),
        );
        expect(
          await signInViewModel
              .onSignIn(
                email: MockDataAuthTest.email,
                password: MockDataAuthTest.password,
              )
              .then((_) => Exception()),
          isA<Exception>(),
        );
      });
    },
  );
}

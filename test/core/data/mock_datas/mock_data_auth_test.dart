import 'package:elearning/core/data/models/user_model.dart';

class MockDataAuthTest {
  /// MOCK DATA TITLE TEST
  static String groupTestSignInViewModelTitle =
      "E-LEANING_TEST_API_SIGN_IN_VIEW_MODEL";

  static String groupTestSignUpViewModelTitle =
      "E-LEANING_TEST_API_SIGN_UP_VIEW_MODEL";

  static String groupTestForgotPasswordViewModelTitle =
      "E-LEANING_TEST_API_FORGOT_PASSWORD_VIEW_MODEL";

  static String groupTestAuthRepositoryTitle =
      "E-LEANING_TEST_API_AUTH_REPOSITORY";

  static String groupTestAuthServiceTitle =
      "E-LEANING_TEST_API_AUTH_REPOSITORY";

  static String signInTitleNotNull =
      "SIGN_IN_API_TEST_SUCCESSFUL_DATA_NOT_NULL";

  static String signInTitleCanNull =
      "SIGN_IN_API_TEST_SUCCESSFUL_DATA_CAN_NULL";

  static String signInTitleFailed =
      "SIGN_IN_API_TEST_FAILED";

  static String signUpTitleNotNull =
      "SIGN_UP_API_TEST_SUCCESSFUL_DATA_NOT_NULL";

  static String signUpTitleCanNull =
      "SIGN_UP_API_TEST_SUCCESSFUL_DATA_CAN_NULL";

  static String signUpTitleFailed =
      "SIGN_UP_API_TEST_FAILED";

  static String forgotPasswordTitleNotNull =
      "FORGOT_PASSWORD_API_TEST_SUCCESSFUL_DATA_NOT_NULL";

  static String forgotPasswordTitleCanNull =
      "FORGOT_PASSWORD_API_TEST_SUCCESSFUL_DATA_CAN_NULL";

  static String forgotPasswordFailed =
      "FORGOT_PASSWORD_API_TEST_FAILED";

  /// MOCK DATA PARAM AND BODY PUSH API OF AUTH

  static String email =
      "haint2@rikkeisoft.com";

  static String password =
      "Hai#2106";

  /// MOCK DATA REPOSITORY FROM API OF AUTH

  static UserModel userModel = UserModel(
    accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjhiOWMzMmNmLWViNWUtNGVlNC05NTNiLTM5MTljOGYwMWUzZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJKYW1lc05ndXllbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImhhaW50MkByaWtrZWlzb2Z0LmNvbSIsImp0aSI6IjBmYTFjM2IxLWI3NDEtNDMxYy1iZTU5LTUxMmRmMzM4NzUxOCIsImV4cCI6MTY2Njg3NzkxNiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MDAwIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo0MjAwIn0.1uB4Tr0xeMwJvs08tUcEgxLpSSeCwpquiChgFL-ZyBg",
    expiration: "2022-10-27T13:38:36Z",
    refreshToken: "TGhSuvKMy7HG0Av9tbtVdrHyxmrezQRrTFZkaxqQ+gtDF94torUOEvVq3wltYZ9V31mQvi/7vBRX5XA2BxhsQQ==",
    expires: 6.9999996993217595,
  );

  static DataResponseModel dataResponseModel = DataResponseModel(
    status: true,
    message: "User created successfully!",
  );
}

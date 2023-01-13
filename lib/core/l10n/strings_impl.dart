import 'package:intl/intl.dart';

// DO NOT EDIT.
mixin StringsImpl {
  String get emailAddress =>
      Intl.message("Email address", name: "emailAddress");

  String get password => Intl.message("Password", name: "password");

  String get letGetStarted => Intl.message("Let's get you started!", name: "letGetStarted");

  String get rememberAccount =>
      Intl.message("Remember me?", name: "rememberAccount");

  String get btnSignIn => Intl.message("Sign In", name: "btnSignIn");
}

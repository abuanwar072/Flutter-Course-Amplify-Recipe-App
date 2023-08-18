import 'dart:math';

import 'package:amplify_recipe/shared/data/authentication_repository.dart';

class MockAuthenticationRepository extends AuthenticationRepository {
  @override
  String get name => 'Student';

  @override
  String get fullName => 'Flutter Way';

  @override
  String get email => 'student@flutterway.com';

  @override
  Future<void> confirmUser(String email, String confirmationCode) {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> forgotPassword(String email) {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> generateCurrentUserInformation() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<bool> isUserLoggedIn() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => Random().nextBool(),
    );
  }

  @override
  Future<void> logInWithCredentials(String email, String password) {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> logInWithFacebook() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> logInWithGoogle() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> signOut() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> signUp(String email, String password, String name) {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Future<void> confirmPasswordReset(
    String email,
    String newPassword,
    String confirmationCode,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }
}

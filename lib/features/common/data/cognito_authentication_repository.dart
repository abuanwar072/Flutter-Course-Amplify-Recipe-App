import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';

class CognitoAuthenticationRepository extends AuthenticationRepository {
  @override
  String get name =>
      currentUser?.name.split(' ').first ??
      (throw const UserNotFoundException('User has not been retrieved yet'));

  @override
  String get fullName =>
      currentUser?.name ??
      (throw const UsernameExistsException("User has not been retrieved yet"));

  @override
  String get email =>
      currentUser?.email ??
      (throw const UserNotFoundException('User has not been retrieved yet'));

  @override
  Future<void> confirmUser(String email, String confirmationCode) {
    // TODO: implement confirmUser
    throw UnimplementedError();
  }

  @override
  Future<void> generateCurrentUserInformation() {
    // TODO: implement generateCurrentUserInformation
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserLogedIn() {
    // TODO: implement isUserLogedIn
    throw UnimplementedError();
  }

  @override
  Future<void> logInWithCredentials(String email, String password) {
    // TODO: implement logInWithCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> logInWithFacebook() {
    // TODO: implement logInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> logInWithGoogle() {
    // TODO: implement logInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    try {
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: email,
            CognitoUserAttributeKey.name: name,
          },
        ),
      );
    } catch (e) {
      switch (e) {
        case UsernameExistsException:
          safePrint('Username already exists: $e');
          break;
        case InvalidParameterException:
          safePrint('Invalid parameter: $e');
          break;
        case AuthException:
          safePrint('An unknown error occurred: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }
}

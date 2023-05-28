import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/model/user.dart';

class CognitoAuthenticationRepository extends AuthenticationRepository {
  @override
  String get name =>
      currentUser?.name.split(" ").first ??
      (throw const UserNotFoundException("User has not been retrieved yet"));

  @override
  String get fullName =>
      currentUser?.name ??
      (throw const UserNotFoundException("User has not been retrieved yet"));

  @override
  String get email =>
      currentUser?.email ??
      (throw const UserNotFoundException("User has not been retrieved yet"));

  @override
  Future<bool> forgotPassword(String email) async {
    try {
      final result = await Amplify.Auth.resetPassword(username: email);
      return result.isPasswordReset;
    } on AuthException catch (e) {
      switch (e) {
        case NetworkException _:
          safePrint('Network error happened: $e');
        case _:
          safePrint('An unknown error occurred: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> logInWithCredentials(String email, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      if (!result.isSignedIn &&
          result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
        throw const UserNotConfirmedException("User not confirmed");
      }
      await generateCurrentUserInformation();
    } on AuthException catch (e) {
      switch (e) {
        case UserNotFoundException _:
          safePrint('User does not exist: $e');
        case UserNotConfirmedException _:
          safePrint('User is not confirmed exception: $e');
        case _:
          safePrint('An unknown error occurred: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> logInWithFacebook() async {
    try {
      await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.facebook,
      );
      await generateCurrentUserInformation();
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );
      await generateCurrentUserInformation();
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
      rethrow;
    }
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
    } on AuthException catch (e) {
      switch (e) {
        case UsernameExistsException _:
          safePrint('Username already exists: $e');
        case InvalidParameterException _:
          safePrint('Invalid parameter: $e');
        case _:
          safePrint('An unknown error occurred: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> confirmUser(String email, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationCode,
      );
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession(
        options: const FetchAuthSessionOptions(forceRefresh: true),
      );
      if (result.isSignedIn) {
        await generateCurrentUserInformation();
      }
      return result.isSignedIn;
    } on AuthException catch (e) {
      safePrint('Error fetching auth session: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<void> generateCurrentUserInformation() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final userAttributes = await Amplify.Auth.fetchUserAttributes();
      safePrint('user $user');
      safePrint('userAttributes $userAttributes');
      currentUser = User(
        user.userId,
        userAttributes
            .firstWhere(
              (element) =>
                  element.userAttributeKey == CognitoUserAttributeKey.name,
            )
            .value,
        userAttributes
            .firstWhere(
              (element) =>
                  element.userAttributeKey == CognitoUserAttributeKey.email,
            )
            .value,
        profilePicture: userAttributes
            .where(
              (element) =>
                  element.userAttributeKey == CognitoUserAttributeKey.picture,
            )
            .firstOrNull
            ?.value,
      );
    } on AuthException catch (e) {
      safePrint('Error fetching auth session: ${e.message}');
      rethrow;
    }
  }
}

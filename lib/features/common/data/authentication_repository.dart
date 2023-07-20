import 'package:amplify_recipe/features/common/data/model/user.dart';

abstract class AuthenticationRepository {
  late String name;

  late String fullName;

  late String email;

  User? currentUser;

  Future<void> logInWithCredentials(String email, String password);

  Future<void> logInWithGoogle();

  Future<void> logInWithFacebook();

  Future<void> signUp(String email, String password, String name);

  Future<void> forgotPassword(String email);

  Future<void> signOut();

  Future<void> confirmUser(String email, String confirmationCode);

  Future<bool> isUserLoggedIn();

  Future<void> generateCurrentUserInformation();
}

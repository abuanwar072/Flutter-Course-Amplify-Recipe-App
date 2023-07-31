import 'package:amplify_recipe/features/authentication/screens/forgot_password_screen.dart';
import 'package:amplify_recipe/features/authentication/screens/onboarding_screen.dart';
import 'package:amplify_recipe/features/authentication/screens/register_screen.dart';
import 'package:amplify_recipe/features/authentication/screens/resend_email_screen.dart';
import 'package:amplify_recipe/features/authentication/screens/sign_in_screen.dart';
import 'package:amplify_recipe/features/authentication/widgets/user_confirmation_form.dart';
import 'package:amplify_recipe/features/details/screens/recipe_details_screen.dart';
import 'package:amplify_recipe/features/entry_point.dart';
import 'package:amplify_recipe/features/favorite/screens/favorite_screen.dart';
import 'package:amplify_recipe/features/profile/screens/edit_profile_screen.dart';
import 'package:amplify_recipe/features/profile/screens/profile_screen.dart';
import 'package:amplify_recipe/features/recipes/screens/search/screen/all_recipes_screen.dart';
import 'package:amplify_recipe/features/recipes/screens/search/screen/search_screen.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/entry-point',
      builder: (context, state) => const EntryPoint(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/resend-email-verification',
      builder: (context, state) => const EmailResendScreen(),
    ),
    GoRoute(
      path: '/user-confirmation/:email',
      builder: (context, state) {
        final email = state.pathParameters['email'];
        if (email == null) {
          throw Exception('Recipe ID is missing');
        }
        return UserConfirmationForm(email: email);
      },
    ),
    GoRoute(
      path: '/favorite',
      builder: (context, state) => const FavoriteScreen(),
    ),
    GoRoute(
      path: '/recipe/:id/:isFavorited',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final isFavorited = state.pathParameters['isFavorited'];
        if (id == null || isFavorited == null) {
          throw Exception('Recipe ID or Favorite state is missing');
        }
        return RecipeDetailsScreen(
          id: id,
          isFavorited: bool.parse(isFavorited),
        );
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/all-recipes',
      builder: (context, state) => const AllRecipesScreen(),
    ),
    GoRoute(
      path: '/search-recipes',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);

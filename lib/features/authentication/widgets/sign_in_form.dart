import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_recipe/features/authentication/widgets/user_confirmation_form.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/features/entry_point.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/gaps.dart';
import '../../../shared/utils/form_utils.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final _formKey = GlobalKey<FormState>();
  bool _isEnabled = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email address',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: emailController,
            validator: FormUtils.emailValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'user@example.com'),
          ),
          gapH16,
          Text(
            'Password',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: passwordController,
            validator: FormUtils.passwordValidator,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          gapH24,
          ElevatedButton(
            onPressed: _isEnabled
                ? () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isEnabled = false;
                      });
                      getIt
                          .get<AuthenticationRepository>()
                          .logInWithCredentials(
                              emailController.text, passwordController.text)
                          .then((value) {
                        getIt.get<RecipeRepository>().syncRemoteChanges();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryPoint()),
                          (route) => false,
                        );
                      }).onError((error, stackTrace) {
                        setState(() {
                          _isEnabled = true;
                        });
                        switch (error as AuthException) {
                          case UserNotConfirmedException _:
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserConfirmationForm(
                                  email: emailController.text,
                                ),
                              ),
                              (route) => false,
                            );
                          case _:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              ),
                            );
                        }
                      });
                    }
                  }
                : null,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

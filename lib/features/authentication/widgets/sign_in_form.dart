import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/features/entry_point.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/extentions/context_extentions.dart';
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
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

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
            "Email address",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: emailController,
            validator: FormUtils.emailValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "test@mail.com"),
          ),
          gapH16,
          Text(
            "Password",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: passwordController,
            validator: FormUtils.passwordValidator,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Enter your password"),
          ),
          gapH24,
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                    }

                    getIt
                        .get<AuthenticationRepository>()
                        .logInWithCredentials(
                          emailController.text,
                          passwordController.text,
                        )
                        .then(
                          (_) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EntryPoint()),
                            (route) => false,
                          ),
                        )
                        .onError(
                      (error, stackTrace) {
                        setState(() {
                          _isLoading = false;
                        });
                        context.showSnackBar(error.toString());
                      },
                    );
                  },
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Login"),
          ),
        ],
      ),
    );
  }
}

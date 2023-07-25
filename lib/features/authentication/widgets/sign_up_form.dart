import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/gaps.dart';
import '../../../shared/utils/form_utils.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEnabled = true;

  @override
  void dispose() {
    nameController.dispose();
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
            'Full Name',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: nameController,
            validator: FormUtils.requireFieldValidator,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Enter your name'),
          ),
          gapH16,
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
            decoration: const InputDecoration(hintText: 'test@mail.com'),
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
                          .signUp(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                          )
                          .then((value) {
                        context
                            .go('/user-confirmation/${emailController.text}');
                      }).onError(
                        (error, stackTrace) {
                          setState(() {
                            _isEnabled = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                        },
                      );
                    }
                  }
                : null,
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }
}

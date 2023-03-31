import 'package:amplify_recipe/features/home/screens/home_screen.dart';
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
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email address",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            onSaved: (email) {
              email = email!;
            },
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
            onSaved: (password) {
              password = password!;
            },
            validator: FormUtils.passwordValidator,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Enter your password"),
          ),
          gapH24,
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}

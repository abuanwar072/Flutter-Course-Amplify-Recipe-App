import 'package:flutter/material.dart';

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
  late String name, email, password;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            onSaved: (fullName) {
              name = fullName!;
            },
            validator: FormUtils.requireFieldValidator,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "Enter your name"),
          ),
          gapH16,
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
            onPressed: () {},
            child: const Text("Sign up"),
          ),
        ],
      ),
    );
  }
}

import 'package:amplify_recipe/features/authentication/widgets/user_conformation_form.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/extentions/context_extentions.dart';
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
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  bool _isEnable = true;

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
            "Full Name",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: nameController,
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
            onPressed: _isEnable
                ? () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isEnable = true;
                      });
                      getIt
                          .get<AuthenticationRepository>()
                          .signUp(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                          )
                          .then(
                            (value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserConfirmationForm(
                                    email: emailController.text),
                              ),
                              (route) => false,
                            ),
                          )
                          .onError(
                            (error, stackTrace) =>
                                context.showSnackBar(error.toString()),
                          );
                    }
                  }
                : null,
            child: const Text("Sign up"),
          ),
        ],
      ),
    );
  }
}

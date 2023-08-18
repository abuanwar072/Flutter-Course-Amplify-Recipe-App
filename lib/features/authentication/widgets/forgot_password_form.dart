import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/gaps.dart';
import '../../../shared/utils/form_utils.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({
    super.key,
  });

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email address',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          gapH8,
          TextFormField(
            controller: _emailController,
            validator: FormUtils.emailValidator,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'test@mail.com'),
          ),
          gapH24,
          ElevatedButton(
            onPressed: () async {
              await getIt
                  .get<AuthenticationRepository>()
                  .forgotPassword(_emailController.text);
              if (mounted) {
                context.push('/password-confirmation/${_emailController.text}');
              }
            },
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}

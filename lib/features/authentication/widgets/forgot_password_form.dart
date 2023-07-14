import 'package:amplify_recipe/features/authentication/screens/resend_email_screen.dart';
import 'package:amplify_recipe/features/authentication/widgets/user_confirmation_form.dart';
import 'package:amplify_recipe/features/common/data/cognito_authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/material.dart';

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
  late String email;

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
            onSaved: (email) {
              email = email!;
            },
            validator: FormUtils.emailValidator,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'test@mail.com'),
          ),
          gapH24,
          ElevatedButton(
            onPressed: () async {
              final result = await getIt
                  .get<CognitoAuthenticationRepository>()
                  .forgotPassword(email);
              if (result && mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserConfirmationForm(email: email),
                  ),
                );
              }
            },
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}

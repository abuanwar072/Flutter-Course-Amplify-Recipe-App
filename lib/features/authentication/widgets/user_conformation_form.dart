import 'package:amplify_recipe/features/authentication/screens/sign_in_screen.dart';
import 'package:amplify_recipe/features/common/data/cognito_authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/extentions/context_extentions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../../shared/utils/form_utils.dart';
import '../../../thems/app_colors.dart';

class UserConfirmationForm extends StatefulWidget {
  const UserConfirmationForm({
    required this.email,
    super.key,
  });

  final String email;

  @override
  State<UserConfirmationForm> createState() => _UserConfirmationFormState();
}

class _UserConfirmationFormState extends State<UserConfirmationForm> {
  late final TextEditingController confirmationCodeController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirmation Code',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                gapH8,
                TextFormField(
                  controller: confirmationCodeController,
                  validator: FormUtils.requireFieldValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: 'Confirmation Code'),
                ),
                gapH24,
                ElevatedButton(
                  onPressed: _isEnabled
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isEnabled = true;
                            });
                            getIt
                                .get<CognitoAuthenticationRepository>()
                                .confirmUser(widget.email,
                                    confirmationCodeController.text)
                                .then(
                                  (value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen(),
                                    ),
                                  ),
                                )
                                .onError((error, stackTrace) {
                              setState(() {
                                _isEnabled = false;
                              });
                              context.showSnackBar(error.toString());
                            });
                          }
                        }
                      : null,
                  child: const Text('Confirm User'),
                ),
                gapH24,
                Text.rich(
                  TextSpan(
                    text:
                        'Not receiving email? check on promotion page or spam.\n',
                    children: [
                      TextSpan(
                        text: 'Or click here to send the code again.',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: const TextStyle(
                          color: AppColors.primary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

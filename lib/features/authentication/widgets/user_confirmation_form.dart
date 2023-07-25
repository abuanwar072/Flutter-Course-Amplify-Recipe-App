import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../../shared/utils/form_utils.dart';
import '../../../themes/app_colors.dart';

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
                              _isEnabled = false;
                            });
                            getIt
                                .get<AuthenticationRepository>()
                                .confirmUser(
                                  widget.email,
                                  confirmationCodeController.text,
                                )
                                .then((value) {
                              context.push('/sign-in');
                            }).onError((error, stackTrace) {
                              setState(() {
                                _isEnabled = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.toString()),
                                ),
                              );
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

import 'package:form_field_validator/form_field_validator.dart';

class FormUtils {
  static final requireFieldValidator =
      RequiredValidator(errorText: 'This field is required');
  static final emailValidator = EmailValidator(errorText: 'Invalid email');
  static final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Password is required'),
      MinLengthValidator(8,
          errorText: 'Password must be at least 8 digits long'),
    ],
  );
  static MatchValidator matchPassValidator =
      MatchValidator(errorText: 'passwords do not match');
}

import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:jbbase_app/base/data/app_error.dart';
import 'package:jbbase_app/l10n/generated/l10n.dart';

typedef MyFormFieldState = FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>;

enum FormFieldType {
  email,
  password,
}

extension FormFieldTypeExtension on FormFieldType {
  String get labelText {
    switch (this) {
      case FormFieldType.email:
        return S.current.mailaddress;
      case FormFieldType.password:
        return S.current.password;
      default:
        return '';
    }
  }

  String get hintText {
    switch (this) {
      case FormFieldType.email:
        return 'mail@example.com';
      default:
        return '';
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case FormFieldType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  MyFormFieldState field(FormBuilderState formBuilderState) {
    final field = formBuilderState.fields[name];
    if (field == null) {
      throw AppException.invalidInput('Cannot detect state of form key');
    }

    return field;
  }

  FormFieldValidator<String?>? validator() {
    List<FormFieldValidator<String?>> validators = [];
    switch (this) {
      case FormFieldType.email:
        validators = [
          FormBuilderValidators.required(errorText: S.current.empty_email_error_message),
          FormBuilderValidators.email(errorText: S.current.notification_mailaddress),
          FormBuilderValidators.maxLength(128, errorText: S.current.max_length_email_error_message),
        ];
        break;
      case FormFieldType.password:
        validators = [
          FormBuilderValidators.required(errorText: S.current.empty_password_error_message),
          FormBuilderValidators.minLength(8, errorText: S.current.max_length_password_error_message),
        ];
        break;
      default:
        return null;
    }

    return FormBuilderValidators.compose(validators);
  }
}

extension FormKeyExtension on GlobalKey<FormBuilderState> {
  FormBuilderState? get formBuilderState {
    return currentState;
  }
}

extension ListFormFieldState on List<MyFormFieldState> {
  void validateFormFields() {
    FocusManager.instance.primaryFocus?.unfocus();
    final isValid = map((e) => e.validate()).reduce((v, e) => v && e);
    if (!isValid) {
      final errorMessage = map(
        (e) => e.errorText == null ? null : '${e.decoration.labelText}: ${e.errorText}',
      ).whereType<String>().toList().join('\n');
      throw AppException.invalidInput(errorMessage);
    }
  }
}

import '../../../../core/constants/validation_messages.dart';

abstract final class AuthFormValidators {
  static String? fullName(String? value) {
    if (value == null || value.trim().length < 2) {
      return ValidationMessages.fullNameRequired;
    }
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return ValidationMessages.invalidEmail;
    }
    return null;
  }

  static String? signInPassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMessages.passwordRequired;
    }
    return null;
  }

  static String? signUpPassword(String? value) {
    final password = value ?? '';
    if (password.length < 8 ||
        !RegExp('[A-Za-z]').hasMatch(password) ||
        !RegExp('[0-9]').hasMatch(password)) {
      return ValidationMessages.weakPassword;
    }
    return null;
  }

  static String? passwordConfirmation(String? value, String password) {
    if (value != password) {
      return ValidationMessages.passwordsDoNotMatch;
    }
    return null;
  }
}

abstract final class ValidationMessages {
  static const fullNameRequired = 'Enter your full name.';
  static const invalidEmail = 'Enter a valid email address.';
  static const passwordRequired = 'Enter your password.';
  static const weakPassword = 'Use 8+ characters with letters and numbers.';
  static const passwordsDoNotMatch = 'Passwords do not match.';
  static const termsRequired = 'Accept the terms to create an account.';

  static const displayNameRequired = 'Please enter a display name.';
  static const displayNameTooLong =
      'Keep your display name under 40 characters.';
  static const bankRequired = 'Please choose a bank.';
  static const creditCardRequired = 'Please choose a card.';
  static const cardNicknameRequired = 'Please add a card nickname.';
  static const billingDayOutOfRange = 'Billing day must be between 1 and 31.';
  static const creditLimitPositive = 'Enter a credit limit greater than 0.';

  static const transactionCardRequired = 'Please choose a card.';
  static const merchantRequired = 'Please enter a merchant.';
  static const mccRequired = 'Please choose an MCC.';
  static const mccInvalid = 'Enter a valid 4-digit MCC.';
  static const transactionAmountPositive = 'Enter an amount greater than 0.';
}

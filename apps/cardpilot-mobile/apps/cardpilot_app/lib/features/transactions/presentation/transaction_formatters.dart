import 'package:flutter/services.dart';

String formatVnd(int amountMinor) {
  final digits = amountMinor.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index += 1) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[index]);
  }
  return '${buffer.toString()} ₫';
}

String formatAmountInput(int amountMinor) {
  return _separateThousands(amountMinor.toString(), ',');
}

int? parseAmountInput(String value) {
  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
  return digits.isEmpty ? null : int.tryParse(digits);
}

class AmountInputFormatter extends TextInputFormatter {
  const AmountInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final selectionEnd = newValue.selection.end.clamp(0, newValue.text.length);
    final digitsBeforeCursor = newValue.text
        .substring(0, selectionEnd)
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length;
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return TextEditingValue.empty;

    digits = digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final formatted = _separateThousands(digits, ',');
    var offset = 0;
    var seenDigits = 0;
    while (offset < formatted.length && seenDigits < digitsBeforeCursor) {
      if (_isDigit(formatted.codeUnitAt(offset))) seenDigits += 1;
      offset += 1;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

String _separateThousands(String digits, String separator) {
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index += 1) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      buffer.write(separator);
    }
    buffer.write(digits[index]);
  }
  return buffer.toString();
}

bool _isDigit(int codeUnit) => codeUnit >= 48 && codeUnit <= 57;

String formatTransactionDate(DateTime dateTime) {
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  return '${twoDigits(dateTime.day)}/${twoDigits(dateTime.month)}/'
      '${dateTime.year} · ${twoDigits(dateTime.hour)}:'
      '${twoDigits(dateTime.minute)}';
}

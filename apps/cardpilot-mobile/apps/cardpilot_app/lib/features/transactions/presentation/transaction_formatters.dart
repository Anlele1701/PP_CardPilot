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

String formatTransactionDate(DateTime dateTime) {
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  return '${twoDigits(dateTime.day)}/${twoDigits(dateTime.month)}/'
      '${dateTime.year} · ${twoDigits(dateTime.hour)}:'
      '${twoDigits(dateTime.minute)}';
}

class ReceiptScanDraft {
  const ReceiptScanDraft({
    required this.scanId,
    required this.processingMs,
    required this.warnings,
    this.merchant,
    this.address,
    this.occurredAt,
    this.amountMinor,
    this.currency,
    this.merchantConfidencePpm,
    this.totalConfidencePpm,
  });

  final String scanId;
  final int processingMs;
  final String? merchant;
  final String? address;
  final DateTime? occurredAt;
  final int? amountMinor;
  final String? currency;
  final int? merchantConfidencePpm;
  final int? totalConfidencePpm;
  final List<String> warnings;
}

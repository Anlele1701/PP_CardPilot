import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import 'data/receipt_scan_remote_data_source.dart';
import 'domain/receipt_scan_draft.dart';

final receiptScanRemoteDataSourceProvider = Provider(
  (ref) => ReceiptScanRemoteDataSource(baseUrl: AppConfig.ocrBaseUrl),
);

final receiptScanControllerProvider = Provider(
  (ref) =>
      ReceiptScanController(ref.watch(receiptScanRemoteDataSourceProvider)),
);

class ReceiptScanController {
  const ReceiptScanController(this.remote);

  final ReceiptScanRemoteDataSource remote;

  Future<ReceiptScanDraft> scan({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  }) {
    return remote.scan(
      bytes: bytes,
      fileName: fileName,
      contentType: contentType,
    );
  }
}

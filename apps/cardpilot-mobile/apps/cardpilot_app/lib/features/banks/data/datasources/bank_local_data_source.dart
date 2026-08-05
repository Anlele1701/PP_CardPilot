import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/bank.dart';

class BankLocalDataSource {
  const BankLocalDataSource(this.database);

  static const bootstrapDatasetVersion = 1;

  final AppDatabase database;

  Stream<List<Bank>> watchBanks() {
    final query = database.select(database.banksCache)
      ..orderBy([(row) => OrderingTerm.asc(row.name)]);
    return query.watch().map(_toDomainList);
  }

  Future<List<Bank>> getBanks() async {
    final query = database.select(database.banksCache)
      ..orderBy([(row) => OrderingTerm.asc(row.name)]);
    return _toDomainList(await query.get());
  }

  Future<void> replaceBootstrapSnapshot(List<Bank> banks) async {
    if (banks.isEmpty) {
      throw const FormatException('Cannot cache an empty bank catalog.');
    }

    await database.transaction(() async {
      await database.delete(database.banksCache).go();
      await database.batch((batch) {
        batch.insertAll(
          database.banksCache,
          banks
              .map(
                (bank) => BanksCacheCompanion.insert(
                  id: bank.id,
                  swiftCode: Value(bank.swiftCode),
                  name: bank.name,
                  shortName: Value(bank.shortName),
                  datasetVersion: bootstrapDatasetVersion,
                ),
              )
              .toList(growable: false),
        );
      });
    });
  }

  List<Bank> _toDomainList(List<BankCacheRow> rows) {
    return rows
        .map(
          (row) => Bank(
            id: row.id,
            swiftCode: row.swiftCode,
            name: row.name,
            shortName: row.shortName,
          ),
        )
        .toList(growable: false);
  }
}

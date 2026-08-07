import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/credit_card.dart';

class CreditCardLocalDataSource {
  const CreditCardLocalDataSource(this.database);

  static const bootstrapDatasetVersion = 1;

  final AppDatabase database;

  Stream<List<CreditCard>> watchCreditCards(String bankId) {
    final query = database.select(database.creditCardsCache)
      ..where((row) => row.bankId.equals(bankId) & row.isActive.equals(true))
      ..orderBy([(row) => OrderingTerm.asc(row.name)]);
    return query.watch().map(_toDomainList);
  }

  Future<List<CreditCard>> getCreditCards(String bankId) async {
    final query = database.select(database.creditCardsCache)
      ..where((row) => row.bankId.equals(bankId) & row.isActive.equals(true))
      ..orderBy([(row) => OrderingTerm.asc(row.name)]);
    return _toDomainList(await query.get());
  }

  Future<void> replaceBootstrapSnapshot(
    String bankId,
    List<CreditCard> creditCards,
  ) async {
    if (creditCards.isEmpty) {
      return;
    }
    if (creditCards.any((creditCard) => creditCard.bankId != bankId)) {
      throw const FormatException(
        'Cannot cache credit cards belonging to another bank.',
      );
    }

    await database.transaction(() async {
      await (database.delete(
        database.creditCardsCache,
      )..where((row) => row.bankId.equals(bankId))).go();
      await database.batch((batch) {
        batch.insertAll(
          database.creditCardsCache,
          creditCards
              .map(
                (creditCard) => CreditCardsCacheCompanion.insert(
                  id: creditCard.id,
                  bankId: creditCard.bankId,
                  name: creditCard.name,
                  network: Value(creditCard.network),
                  cardType: Value(creditCard.cardType),
                  annualFeeDecimal: Value(creditCard.annualFee),
                  sourceUrl: Value(creditCard.sourceUrl),
                  lastVerifiedAtMs: Value(
                    creditCard.lastVerifiedAt?.millisecondsSinceEpoch,
                  ),
                  datasetVersion: bootstrapDatasetVersion,
                ),
              )
              .toList(growable: false),
        );
      });
    });
  }

  List<CreditCard> _toDomainList(List<CreditCardCacheRow> rows) {
    return rows
        .map(
          (row) => CreditCard(
            id: row.id,
            bankId: row.bankId,
            name: row.name,
            network: row.network,
            cardType: row.cardType,
            annualFee: row.annualFeeDecimal,
            sourceUrl: row.sourceUrl,
            lastVerifiedAt: row.lastVerifiedAtMs == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(
                    row.lastVerifiedAtMs!,
                    isUtc: true,
                  ),
          ),
        )
        .toList(growable: false);
  }
}

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../domain/merchant_directory.dart';

class MerchantLocalDataSource {
  const MerchantLocalDataSource(this.database, {Uuid uuid = const Uuid()})
    : _uuid = uuid;

  static const _datasetVersion = 1;
  final AppDatabase database;
  final Uuid _uuid;

  Future<void> replaceDirectory(List<MerchantBranch> branches) async {
    if (branches.isEmpty) return;
    await database.transaction(() async {
      await database.delete(database.merchantMccCandidatesCache).go();
      await database.delete(database.merchantBranchesCache).go();
      await database.batch((batch) {
        batch.insertAll(
          database.merchantBranchesCache,
          branches
              .map(
                (branch) => MerchantBranchesCacheCompanion.insert(
                  id: branch.id,
                  name: branch.name,
                  nameNormalized: branch.nameNormalized,
                  locationText: Value(branch.locationText),
                  datasetVersion: const Value(_datasetVersion),
                ),
              )
              .toList(growable: false),
        );
        batch.insertAll(
          database.merchantMccCandidatesCache,
          branches
              .expand(
                (branch) => branch.mccMappings.map(
                  (mapping) => MerchantMccCandidatesCacheCompanion.insert(
                    id: mapping.id,
                    merchantServerId: branch.id,
                    merchantName: branch.name,
                    merchantNameNormalized: branch.nameNormalized,
                    locationText: Value(branch.locationText),
                    mccCode: mapping.mccCode,
                    mccDescription: Value(mapping.mccDescription),
                    paymentType: Value(mapping.paymentType.wireValue),
                    source: mapping.source,
                    confidencePpm: Value(mapping.confidencePpm),
                    status: mapping.status,
                    datasetVersion: const Value(_datasetVersion),
                  ),
                ),
              )
              .toList(growable: false),
        );
      });
    });
  }

  Future<List<MerchantDirectoryEntry>> getDirectory(String profileId) async {
    final branches =
        await (database.select(database.merchantBranchesCache)..orderBy([
              (row) => OrderingTerm.asc(row.nameNormalized),
              (row) => OrderingTerm.asc(row.locationText),
            ]))
            .get();
    if (branches.isEmpty) return const [];

    final branchIds = branches.map((item) => item.id).toList(growable: false);
    final candidates = await (database.select(
      database.merchantMccCandidatesCache,
    )..where((row) => row.merchantServerId.isIn(branchIds))).get();
    final contributions = await (database.select(
      database.localMerchantMccContributions,
    )..where((row) => row.profileId.equals(profileId))).get();

    final mappedBranches = branches
        .map((branch) {
          final remote = candidates
              .where((item) => item.merchantServerId == branch.id)
              .map(
                (item) => MerchantMccMapping(
                  id: item.id,
                  mccCode: item.mccCode,
                  mccDescription: item.mccDescription,
                  paymentType: MerchantPaymentType.fromWire(item.paymentType),
                  source: item.source,
                  status: item.status,
                  confidencePpm: item.confidencePpm,
                ),
              );
          final local = contributions
              .where((item) => item.merchantServerId == branch.id)
              .map(
                (item) => MerchantMccMapping(
                  id: item.id,
                  mccCode: item.mccCode,
                  mccDescription: item.mccDescriptionSnapshot,
                  paymentType: MerchantPaymentType.fromWire(item.paymentType),
                  source: 'user_local',
                  status: 'local',
                  isLocalContribution: true,
                  note: item.note,
                ),
              );
          return MerchantBranch(
            id: branch.id,
            name: branch.name,
            nameNormalized: branch.nameNormalized,
            locationText: branch.locationText,
            mccMappings: [...remote, ...local],
          );
        })
        .toList(growable: false);

    final groups = <String, List<MerchantBranch>>{};
    for (final branch in mappedBranches) {
      groups.putIfAbsent(branch.nameNormalized, () => []).add(branch);
    }
    return groups.entries
        .map(
          (entry) => MerchantDirectoryEntry(
            key: entry.key,
            name: entry.value.first.name,
            branches: entry.value,
          ),
        )
        .toList(growable: false);
  }

  Future<void> saveContribution(MerchantContributionDraft draft) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await database
        .into(database.localMerchantMccContributions)
        .insert(
          LocalMerchantMccContributionsCompanion.insert(
            id: _uuid.v4(),
            profileId: draft.profileId,
            merchantServerId: draft.branch.id,
            merchantNameSnapshot: draft.branch.name,
            locationText: Value(draft.branch.locationText),
            mccCode: draft.mccCode,
            mccDescriptionSnapshot: Value(draft.mccDescription),
            paymentType: draft.paymentType.wireValue,
            note: Value(
              draft.note?.trim().isEmpty == true ? null : draft.note?.trim(),
            ),
            createdAtMs: now,
            updatedAtMs: now,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}

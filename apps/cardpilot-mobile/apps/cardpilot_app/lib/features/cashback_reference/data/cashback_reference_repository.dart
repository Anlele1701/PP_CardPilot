import '../../../core/network/api_exception.dart';
import '../domain/cashback_reference.dart';
import 'cashback_reference_local_data_source.dart';
import 'cashback_reference_remote_data_source.dart';

class CashbackReferenceSnapshot {
  const CashbackReferenceSnapshot({required this.mccs, required this.rules});

  final List<MerchantCategoryCode> mccs;
  final List<RewardRule> rules;
}

class CashbackReferenceRepository {
  const CashbackReferenceRepository({
    required this.local,
    required this.remote,
  });

  final CashbackReferenceLocalDataSource local;
  final CashbackReferenceRemoteDataSource remote;

  Future<List<MerchantCategoryCode>> ensureMccCatalogLoaded() async {
    var mccs = await local.getMccs();
    if (mccs.isNotEmpty) return mccs;
    await local.replaceMccs(await remote.fetchMccs());
    mccs = await local.getMccs();
    return mccs;
  }

  Future<CashbackReferenceSnapshot> ensureLoaded(String creditCardId) async {
    var mccs = await local.getMccs();
    var rules = await local.getRules(creditCardId);
    if (mccs.isNotEmpty && rules.isNotEmpty) {
      return CashbackReferenceSnapshot(mccs: mccs, rules: rules);
    }

    final remoteMccs = await remote.fetchMccs();
    final remoteRules = await remote.fetchRewardRules(creditCardId);
    await local.replaceMccs(remoteMccs);
    await local.replaceRules(creditCardId, remoteRules);
    mccs = await local.getMccs();
    rules = await local.getRules(creditCardId);
    return CashbackReferenceSnapshot(mccs: mccs, rules: rules);
  }

  Future<List<MerchantMccSuggestion>> suggestMerchantMccs(String query) async {
    try {
      final suggestions = await remote.fetchMerchantSuggestions(query);
      await local.cacheSuggestions(suggestions);
      return suggestions;
    } on ApiException {
      return local.getSuggestions(query);
    }
  }
}

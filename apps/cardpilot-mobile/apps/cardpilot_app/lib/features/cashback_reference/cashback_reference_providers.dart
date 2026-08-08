import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_providers.dart';
import '../../core/network/network_providers.dart';
import 'data/cashback_reference_local_data_source.dart';
import 'data/cashback_reference_remote_data_source.dart';
import 'data/cashback_reference_repository.dart';
import 'domain/cashback_reference.dart';

enum CashbackReferenceStatus { idle, loading, ready, searching, failure }

class CashbackReferenceState {
  const CashbackReferenceState({
    required this.status,
    this.creditCardId,
    this.mccs = const [],
    this.rules = const [],
    this.merchantSuggestions = const [],
    this.errorMessage,
  });

  const CashbackReferenceState.idle()
    : status = CashbackReferenceStatus.idle,
      creditCardId = null,
      mccs = const [],
      rules = const [],
      merchantSuggestions = const [],
      errorMessage = null;

  final CashbackReferenceStatus status;
  final String? creditCardId;
  final List<MerchantCategoryCode> mccs;
  final List<RewardRule> rules;
  final List<MerchantMccSuggestion> merchantSuggestions;
  final String? errorMessage;

  List<MerchantCategoryCode> get eligibleMccs {
    final codes = rules
        .expand((rule) => rule.mccs)
        .where((mapping) {
          final type = mapping.matchType.toLowerCase();
          return type != 'excluded' && type != 'ineligible';
        })
        .map((mapping) => mapping.mccCode)
        .toSet();
    return mccs
        .where((mcc) => codes.contains(mcc.code))
        .toList(growable: false);
  }
}

class CashbackReferenceController extends Notifier<CashbackReferenceState> {
  int _searchSequence = 0;

  @override
  CashbackReferenceState build() => const CashbackReferenceState.idle();

  Future<void> ensureLoaded(String creditCardId) async {
    if (state.creditCardId == creditCardId &&
        state.status == CashbackReferenceStatus.ready) {
      return;
    }
    state = CashbackReferenceState(
      status: CashbackReferenceStatus.loading,
      creditCardId: creditCardId,
    );
    try {
      final snapshot = await ref
          .read(cashbackReferenceRepositoryProvider)
          .ensureLoaded(creditCardId);
      if (state.creditCardId != creditCardId) return;
      state = CashbackReferenceState(
        status: CashbackReferenceStatus.ready,
        creditCardId: creditCardId,
        mccs: snapshot.mccs,
        rules: snapshot.rules,
      );
    } on Object {
      if (state.creditCardId != creditCardId) return;
      state = CashbackReferenceState(
        status: CashbackReferenceStatus.failure,
        creditCardId: creditCardId,
        errorMessage: 'Could not load MCC and reward data.',
      );
    }
  }

  Future<void> searchMerchant(String query) async {
    final sequence = ++_searchSequence;
    final trimmed = query.trim();
    if (trimmed.length < 2 || state.creditCardId == null) {
      state = CashbackReferenceState(
        status: CashbackReferenceStatus.ready,
        creditCardId: state.creditCardId,
        mccs: state.mccs,
        rules: state.rules,
      );
      return;
    }
    final cardId = state.creditCardId;
    state = CashbackReferenceState(
      status: CashbackReferenceStatus.searching,
      creditCardId: cardId,
      mccs: state.mccs,
      rules: state.rules,
      merchantSuggestions: state.merchantSuggestions,
    );
    try {
      final suggestions = await ref
          .read(cashbackReferenceRepositoryProvider)
          .suggestMerchantMccs(trimmed);
      if (state.creditCardId != cardId || sequence != _searchSequence) return;
      state = CashbackReferenceState(
        status: CashbackReferenceStatus.ready,
        creditCardId: cardId,
        mccs: state.mccs,
        rules: state.rules,
        merchantSuggestions: suggestions,
      );
    } on Object {
      if (state.creditCardId != cardId || sequence != _searchSequence) return;
      state = CashbackReferenceState(
        status: CashbackReferenceStatus.ready,
        creditCardId: cardId,
        mccs: state.mccs,
        rules: state.rules,
        merchantSuggestions: const [],
        errorMessage: 'Could not search merchant MCC suggestions.',
      );
    }
  }
}

final cashbackReferenceLocalDataSourceProvider =
    Provider<CashbackReferenceLocalDataSource>(
      (ref) => CashbackReferenceLocalDataSource(ref.watch(appDatabaseProvider)),
    );

final cashbackReferenceRemoteDataSourceProvider =
    Provider<CashbackReferenceRemoteDataSource>(
      (ref) => CashbackReferenceRemoteDataSource(ref.watch(apiClientProvider)),
    );

final cashbackReferenceRepositoryProvider =
    Provider<CashbackReferenceRepository>(
      (ref) => CashbackReferenceRepository(
        local: ref.watch(cashbackReferenceLocalDataSourceProvider),
        remote: ref.watch(cashbackReferenceRemoteDataSourceProvider),
      ),
    );

final cashbackReferenceControllerProvider =
    NotifierProvider<CashbackReferenceController, CashbackReferenceState>(
      CashbackReferenceController.new,
    );

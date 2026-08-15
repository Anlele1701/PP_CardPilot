import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_providers.dart';
import '../../core/network/network_providers.dart';
import '../cashback_reference/cashback_reference_providers.dart';
import '../cashback_reference/domain/cashback_reference.dart';
import 'data/merchant_local_data_source.dart';
import 'data/merchant_remote_data_source.dart';
import 'data/merchant_repository.dart';
import 'domain/merchant_directory.dart';

enum MerchantDirectoryStatus { idle, loading, ready, failure }

class MerchantDirectoryState {
  const MerchantDirectoryState({
    required this.status,
    this.profileId,
    this.merchants = const [],
    this.mccs = const [],
    this.errorMessage,
  });

  const MerchantDirectoryState.idle()
    : status = MerchantDirectoryStatus.idle,
      profileId = null,
      merchants = const [],
      mccs = const [],
      errorMessage = null;

  final MerchantDirectoryStatus status;
  final String? profileId;
  final List<MerchantDirectoryEntry> merchants;
  final List<MerchantCategoryCode> mccs;
  final String? errorMessage;
}

class MerchantDirectoryController extends Notifier<MerchantDirectoryState> {
  Future<void>? _inFlightLoad;

  @override
  MerchantDirectoryState build() => const MerchantDirectoryState.idle();

  Future<void> ensureLoaded(String profileId) {
    if (state.profileId == profileId &&
        state.status == MerchantDirectoryStatus.ready) {
      return Future.value();
    }
    return _inFlightLoad ??= _load(profileId).whenComplete(() {
      _inFlightLoad = null;
    });
  }

  Future<void> retry(String profileId) => _load(profileId);

  Future<void> _load(String profileId) async {
    state = MerchantDirectoryState(
      status: MerchantDirectoryStatus.loading,
      profileId: profileId,
      merchants: state.profileId == profileId ? state.merchants : const [],
      mccs: state.mccs,
    );
    try {
      final merchants = await ref
          .read(merchantRepositoryProvider)
          .ensureLoaded(profileId);
      var mccs = state.mccs;
      try {
        mccs = await ref
            .read(cashbackReferenceRepositoryProvider)
            .ensureMccCatalogLoaded();
      } on Object {
        // Merchant browsing still works if the optional MCC picker catalog
        // cannot be refreshed. Pull-to-refresh retries both resources.
      }
      state = MerchantDirectoryState(
        status: MerchantDirectoryStatus.ready,
        profileId: profileId,
        merchants: merchants,
        mccs: mccs,
      );
    } on Object {
      state = MerchantDirectoryState(
        status: MerchantDirectoryStatus.failure,
        profileId: profileId,
        merchants: state.merchants,
        mccs: state.mccs,
        errorMessage: 'Could not load merchants. Check your connection.',
      );
    }
  }

  Future<void> addContribution(MerchantContributionDraft draft) async {
    await ref.read(merchantRepositoryProvider).saveContribution(draft);
    final merchants = await ref
        .read(merchantRepositoryProvider)
        .getLocal(draft.profileId);
    state = MerchantDirectoryState(
      status: MerchantDirectoryStatus.ready,
      profileId: draft.profileId,
      merchants: merchants,
      mccs: state.mccs,
    );
  }

  Future<MerchantSelection> createLocalMerchant(
    LocalMerchantDraft draft,
  ) async {
    final selection = await ref
        .read(merchantRepositoryProvider)
        .createLocalMerchant(draft);
    final merchants = await ref
        .read(merchantRepositoryProvider)
        .getLocal(draft.profileId);
    state = MerchantDirectoryState(
      status: MerchantDirectoryStatus.ready,
      profileId: draft.profileId,
      merchants: merchants,
      mccs: state.mccs,
    );
    return selection;
  }
}

final merchantLocalDataSourceProvider = Provider<MerchantLocalDataSource>(
  (ref) => MerchantLocalDataSource(ref.watch(appDatabaseProvider)),
);

final merchantRemoteDataSourceProvider = Provider<MerchantRemoteDataSource>(
  (ref) => MerchantRemoteDataSource(ref.watch(apiClientProvider)),
);

final merchantRepositoryProvider = Provider<MerchantRepository>(
  (ref) => MerchantRepository(
    local: ref.watch(merchantLocalDataSourceProvider),
    remote: ref.watch(merchantRemoteDataSourceProvider),
  ),
);

final merchantDirectoryControllerProvider =
    NotifierProvider<MerchantDirectoryController, MerchantDirectoryState>(
      MerchantDirectoryController.new,
    );

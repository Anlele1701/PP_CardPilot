import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/database_providers.dart';
import '../auth/auth_providers.dart';
import 'data/datasources/initial_setup_local_data_source.dart';
import 'data/repositories/initial_setup_repository_impl.dart';
import 'domain/entities/access_mode.dart';
import 'domain/entities/local_user_card.dart';
import 'domain/entities/local_workspace.dart';
import 'domain/repositories/initial_setup_repository.dart';
import 'domain/usecases/complete_initial_setup.dart';

enum InitialSetupStatus { editing, saving, completed, failure }

class InitialSetupState {
  const InitialSetupState({
    required this.status,
    this.accessMode,
    this.displayName = '',
    this.workspace,
    this.errorMessage,
  });

  const InitialSetupState.initial()
    : status = InitialSetupStatus.editing,
      accessMode = null,
      displayName = '',
      workspace = null,
      errorMessage = null;

  final InitialSetupStatus status;
  final AccessMode? accessMode;
  final String displayName;
  final LocalWorkspace? workspace;
  final String? errorMessage;

  InitialSetupState copyWith({
    InitialSetupStatus? status,
    AccessMode? accessMode,
    String? displayName,
    LocalWorkspace? workspace,
    String? errorMessage,
  }) {
    return InitialSetupState(
      status: status ?? this.status,
      accessMode: accessMode ?? this.accessMode,
      displayName: displayName ?? this.displayName,
      workspace: workspace ?? this.workspace,
      errorMessage: errorMessage,
    );
  }
}

class InitialSetupController extends Notifier<InitialSetupState> {
  @override
  InitialSetupState build() => const InitialSetupState.initial();

  void selectAccessMode(AccessMode accessMode) {
    state = state.copyWith(
      status: InitialSetupStatus.editing,
      accessMode: accessMode,
      errorMessage: null,
    );
  }

  void saveDisplayName(String displayName) {
    state = state.copyWith(
      status: InitialSetupStatus.editing,
      displayName: displayName.trim(),
      errorMessage: null,
    );
  }

  void restore(LocalWorkspace workspace) {
    state = InitialSetupState(
      status: InitialSetupStatus.completed,
      accessMode: workspace.accessMode,
      displayName: workspace.profile.displayName,
      workspace: workspace,
    );
  }

  void replaceCards(List<LocalUserCard> cards) {
    final workspace = state.workspace;
    if (workspace == null) {
      return;
    }

    state = state.copyWith(
      workspace: LocalWorkspace(
        localId: workspace.localId,
        accessMode: workspace.accessMode,
        profile: workspace.profile,
        cards: List.unmodifiable(cards),
      ),
      errorMessage: null,
    );
  }

  Future<bool> complete({
    required String bankId,
    required String bankName,
    required String creditCardId,
    required String cardNickname,
    required int billingCycleDay,
  }) async {
    final accessMode = state.accessMode;

    if (accessMode == null) {
      state = state.copyWith(
        status: InitialSetupStatus.failure,
        errorMessage: 'Choose how you want to use CardPilot first.',
      );
      return false;
    }

    if (state.displayName.isEmpty) {
      state = state.copyWith(
        status: InitialSetupStatus.failure,
        errorMessage: 'Add your name before creating a card.',
      );
      return false;
    }

    state = state.copyWith(
      status: InitialSetupStatus.saving,
      errorMessage: null,
    );

    final authUser = ref.read(currentAuthUserProvider);
    final result = await ref.read(completeInitialSetupProvider)(
      accessMode: accessMode,
      displayName: state.displayName,
      bankId: bankId,
      bankName: bankName,
      creditCardId: creditCardId,
      cardNickname: cardNickname,
      billingCycleDay: billingCycleDay,
      authUserId: accessMode == AccessMode.authenticated ? authUser?.id : null,
      email: accessMode == AccessMode.authenticated ? authUser?.email : null,
    );

    return result.when(
      success: (workspace) {
        state = state.copyWith(
          status: InitialSetupStatus.completed,
          workspace: workspace,
          errorMessage: null,
        );
        return true;
      },
      failure: (failure) {
        state = state.copyWith(
          status: InitialSetupStatus.failure,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }
}

final initialSetupLocalDataSourceProvider =
    Provider<InitialSetupLocalDataSource>(
      (ref) =>
          InitialSetupLocalDataSource(database: ref.watch(appDatabaseProvider)),
    );

final initialSetupRepositoryProvider = Provider<InitialSetupRepository>((ref) {
  return InitialSetupRepositoryImpl(
    localDataSource: ref.watch(initialSetupLocalDataSourceProvider),
  );
});

final completeInitialSetupProvider = Provider<CompleteInitialSetup>((ref) {
  return CompleteInitialSetup(
    ref.watch(initialSetupRepositoryProvider),
    generateId: const Uuid().v4,
  );
});

final initialSetupControllerProvider =
    NotifierProvider<InitialSetupController, InitialSetupState>(
      InitialSetupController.new,
    );

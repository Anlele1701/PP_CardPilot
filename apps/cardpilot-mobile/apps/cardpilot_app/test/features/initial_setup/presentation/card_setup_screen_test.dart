import 'dart:async';

import 'package:cardpilot_app/core/errors/app_failure.dart';
import 'package:cardpilot_app/core/result/result.dart';
import 'package:cardpilot_app/features/banks/bank_providers.dart';
import 'package:cardpilot_app/features/banks/domain/entities/bank.dart';
import 'package:cardpilot_app/features/banks/domain/repositories/bank_repository.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/access_mode.dart';
import 'package:cardpilot_app/features/initial_setup/initial_setup_providers.dart';
import 'package:cardpilot_app/features/initial_setup/presentation/views/card_setup_screen.dart';
import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('empty cache loads once then opens the bank picker', (
    tester,
  ) async {
    final result = Completer<Result<List<Bank>>>();
    final repository = _FakeBankRepository(
      cachedBanks: const [],
      results: [result.future],
    );
    await _pumpScreen(tester, repository);

    await tester.tap(find.byKey(const Key('bank-picker-field')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(repository.ensureCallCount, 1);

    result.complete(const Success([_acb]));
    await tester.pumpAndSettle();

    expect(find.text('Choose your bank'), findsOneWidget);
    expect(find.byKey(const Key('bank-option-bank-acb')), findsOneWidget);
  });

  testWidgets('populated cache opens immediately without an API load', (
    tester,
  ) async {
    final repository = _FakeBankRepository(cachedBanks: const [_acb]);
    await _pumpScreen(tester, repository);

    await tester.tap(find.byKey(const Key('bank-picker-field')));
    await tester.pumpAndSettle();

    expect(find.text('Choose your bank'), findsOneWidget);
    expect(repository.ensureCallCount, 0);
  });

  testWidgets('a failed load shows an error and allows retry', (tester) async {
    final repository = _FakeBankRepository(
      cachedBanks: const [],
      results: [
        Future.value(
          const Failure(
            AppFailure('Loading banks timed out. Please try again.'),
          ),
        ),
        Future.value(const Success([_acb])),
      ],
    );
    await _pumpScreen(tester, repository);

    await tester.tap(find.byKey(const Key('bank-picker-field')));
    await tester.pumpAndSettle();

    expect(
      find.text('Loading banks timed out. Please try again.'),
      findsOneWidget,
    );
    expect(repository.ensureCallCount, 1);

    await tester.tap(find.byKey(const Key('bank-picker-field')));
    await tester.pumpAndSettle();

    expect(repository.ensureCallCount, 2);
    expect(find.byKey(const Key('bank-option-bank-acb')), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });
}

Future<void> _pumpScreen(WidgetTester tester, BankRepository repository) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        bankRepositoryProvider.overrideWithValue(repository),
        initialSetupControllerProvider.overrideWith(
          _ReadyInitialSetupController.new,
        ),
      ],
      child: MaterialApp(theme: AppTheme.light, home: const CardSetupScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

class _ReadyInitialSetupController extends InitialSetupController {
  @override
  InitialSetupState build() {
    return const InitialSetupState(
      status: InitialSetupStatus.editing,
      accessMode: AccessMode.guest,
      displayName: 'An',
    );
  }
}

class _FakeBankRepository implements BankRepository {
  _FakeBankRepository({required this.cachedBanks, this.results = const []});

  final List<Bank> cachedBanks;
  final List<Future<Result<List<Bank>>>> results;
  int ensureCallCount = 0;

  @override
  Future<Result<List<Bank>>> ensureBanksLoaded() {
    final result = results[ensureCallCount];
    ensureCallCount++;
    return result;
  }

  @override
  Stream<List<Bank>> watchBanks() => Stream.value(cachedBanks);
}

const _acb = Bank(
  id: 'bank-acb',
  swiftCode: 'ASCBVNVX',
  name: 'Ngân hàng Á Châu',
  shortName: 'ACB',
);

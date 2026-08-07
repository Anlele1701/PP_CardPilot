import 'dart:async';

import 'package:cardpilot_app/core/database/app_database.dart';
import 'package:cardpilot_app/core/network/api_client.dart';
import 'package:cardpilot_app/features/banks/data/datasources/bank_local_data_source.dart';
import 'package:cardpilot_app/features/banks/data/datasources/bank_remote_data_source.dart';
import 'package:cardpilot_app/features/banks/data/repositories/bank_repository_impl.dart';
import 'package:cardpilot_app/features/banks/domain/entities/bank.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late BankLocalDataSource localDataSource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    localDataSource = BankLocalDataSource(database);
  });

  tearDown(() => database.close());

  test('returns a populated cache without calling the API', () async {
    await localDataSource.replaceBootstrapSnapshot(const [_acb]);
    final api = _FakeApiClient(response: const [_acbJson]);
    final repository = _repository(localDataSource, api);

    final result = await repository.ensureBanksLoaded();

    expect(
      result.when(
        success: (banks) => banks.map((bank) => bank.id).toList(),
        failure: (_) => <String>[],
      ),
      ['bank-acb'],
    );
    expect(api.callCount, 0);
  });

  test('loads an empty cache once and persists the complete snapshot', () async {
    final api = _FakeApiClient(response: const [_mbJson, _acbJson]);
    final repository = _repository(localDataSource, api);

    final result = await repository.ensureBanksLoaded();

    expect(api.callCount, 1);
    final banks = result.when(success: (value) => value, failure: (_) => []);
    expect(banks.map((bank) => bank.id), ['bank-mb', 'bank-acb']);
    expect((await localDataSource.getBanks()).map((bank) => bank.id), [
      'bank-mb',
      'bank-acb',
    ]);

    final syncStateCount = await database
        .customSelect(
          "SELECT count(*) AS amount FROM sync_state WHERE scope = 'reference:banks'",
        )
        .getSingle();
    expect(syncStateCount.read<int>('amount'), 0);

    final versions = await database
        .customSelect('SELECT DISTINCT dataset_version FROM banks_cache')
        .get();
    expect(versions.single.read<int>('dataset_version'), 1);
  });

  test('does not leave partial cache data after an invalid response', () async {
    final api = _FakeApiClient(
      response: const [
        _acbJson,
        {'id': 'broken'},
      ],
    );
    final repository = _repository(localDataSource, api);

    final result = await repository.ensureBanksLoaded();

    expect(result.when(success: (_) => false, failure: (_) => true), isTrue);
    expect(await localDataSource.getBanks(), isEmpty);
  });

  test('shares one in-flight request between concurrent callers', () async {
    final response = Completer<Object?>();
    final api = _FakeApiClient(completer: response);
    final repository = _repository(localDataSource, api);

    final first = repository.ensureBanksLoaded();
    final second = repository.ensureBanksLoaded();
    await Future<void>.delayed(Duration.zero);
    expect(api.callCount, 1);

    response.complete(const [_acbJson]);
    final results = await Future.wait([first, second]);

    expect(api.callCount, 1);
    expect(
      results[0].when(
        success: (banks) => banks.single.id,
        failure: (_) => null,
      ),
      'bank-acb',
    );
    expect(
      results[1].when(
        success: (banks) => banks.single.id,
        failure: (_) => null,
      ),
      'bank-acb',
    );
  });
}

BankRepositoryImpl _repository(
  BankLocalDataSource localDataSource,
  ApiClient apiClient,
) {
  return BankRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: BankRemoteDataSource(apiClient),
  );
}

const _acb = Bank(
  id: 'bank-acb',
  swiftCode: 'ASCBVNVX',
  name: 'Ngân hàng Á Châu',
  shortName: 'ACB',
);

const _acbJson = <String, Object?>{
  'id': 'bank-acb',
  'swiftCode': 'ASCBVNVX',
  'name': 'Ngân hàng Á Châu',
  'shortName': 'ACB',
};

const _mbJson = <String, Object?>{
  'id': 'bank-mb',
  'swiftCode': 'MSCBVNVX',
  'name': 'Ngân hàng Quân Đội',
  'shortName': 'MB',
};

class _FakeApiClient implements ApiClient {
  _FakeApiClient({this.response, this.completer});

  final Object? response;
  final Completer<Object?>? completer;
  int callCount = 0;

  @override
  Future<T> get<T>(
    String path, {
    Map<String, Object?>? queryParameters,
    required T Function(Object? data) decode,
  }) async {
    callCount++;
    expect(path, '/api/v1/banks');
    final data = completer == null ? response : await completer!.future;
    return decode(data);
  }
}

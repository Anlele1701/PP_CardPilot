import '../domain/merchant_directory.dart';
import 'merchant_local_data_source.dart';
import 'merchant_remote_data_source.dart';

class MerchantRepository {
  const MerchantRepository({required this.local, required this.remote});

  final MerchantLocalDataSource local;
  final MerchantRemoteDataSource remote;

  Future<List<MerchantDirectoryEntry>> ensureLoaded(String profileId) async {
    final localDirectory = await local.getDirectory(profileId);
    if (await local.hasCachedDirectory()) {
      return localDirectory;
    }

    try {
      final remoteBranches = await remote.fetchDirectory();
      await local.replaceDirectory(remoteBranches);
      return local.getDirectory(profileId);
    } on Object {
      if (localDirectory.isNotEmpty) return localDirectory;
      rethrow;
    }
  }

  Future<List<MerchantDirectoryEntry>> getLocal(String profileId) {
    return local.getDirectory(profileId);
  }

  Future<void> saveContribution(MerchantContributionDraft draft) {
    return local.saveContribution(draft);
  }

  Future<MerchantSelection> createLocalMerchant(LocalMerchantDraft draft) {
    return local.createLocalMerchant(draft);
  }
}

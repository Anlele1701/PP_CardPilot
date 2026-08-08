import '../domain/merchant_directory.dart';
import 'merchant_local_data_source.dart';
import 'merchant_remote_data_source.dart';

class MerchantRepository {
  const MerchantRepository({required this.local, required this.remote});

  final MerchantLocalDataSource local;
  final MerchantRemoteDataSource remote;

  Future<List<MerchantDirectoryEntry>> ensureLoaded(String profileId) async {
    final cached = await local.getDirectory(profileId);
    if (cached.isNotEmpty) return cached;

    final remoteBranches = await remote.fetchDirectory();
    await local.replaceDirectory(remoteBranches);
    return local.getDirectory(profileId);
  }

  Future<List<MerchantDirectoryEntry>> getLocal(String profileId) {
    return local.getDirectory(profileId);
  }

  Future<void> saveContribution(MerchantContributionDraft draft) {
    return local.saveContribution(draft);
  }
}

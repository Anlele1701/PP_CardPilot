import 'access_mode.dart';
import 'local_profile.dart';
import 'local_user_card.dart';

class LocalWorkspace {
  const LocalWorkspace({
    required this.localId,
    required this.accessMode,
    required this.profile,
    required this.cards,
  });

  final String localId;
  final AccessMode accessMode;
  final LocalProfile profile;
  final List<LocalUserCard> cards;
}

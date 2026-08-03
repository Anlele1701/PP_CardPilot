import 'package:cardpilot_app/features/auth/domain/usecases/sign_out.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  test('signs out through the auth repository', () async {
    final repository = FakeAuthRepository();
    final signOut = SignOut(repository);

    final result = await signOut();

    expect(repository.signOutCallCount, 1);
    expect(result.when(success: (_) => true, failure: (_) => false), isTrue);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_div_new/Services/auth_service.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('AuthService Test', () {
    test('Sign in berhasil', () async {
      final authService = AuthService();
      final user = await authService.signInWithEmailAndPassword('ashkh224@gmail.com', 'ashkh12345');
      expect(user, isNotNull);
      expect(user?.email, 'ashkh224@gmail.com');
    });

    // Tambahkan tes lain seperti signUp, resetPassword, dll.
  });
}

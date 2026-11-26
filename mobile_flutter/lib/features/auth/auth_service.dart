import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw StateError('Firebase did not return the created user.');
    }

    try {
      await user.updateDisplayName(name.trim());
      await _auth.setLanguageCode('id');
      await user.sendEmailVerification();
    } finally {
      await _auth.signOut();
    }
  }

  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    await _auth.setLanguageCode('id');
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  static Future<void> signOut() => _auth.signOut();
}

String authErrorMessage(FirebaseAuthException error) {
  switch (error.code) {
    case 'email-already-in-use':
      return 'Email ini sudah terdaftar.';
    case 'invalid-email':
      return 'Format email tidak valid.';
    case 'weak-password':
      return 'Password terlalu lemah. Gunakan minimal 6 karakter.';
    case 'user-not-found':
      return 'Email ini belum terdaftar.';
    case 'wrong-password':
    case 'invalid-credential':
    case 'invalid-login-credentials':
      return 'Email atau password salah.';
    case 'user-disabled':
      return 'Akun ini dinonaktifkan.';
    case 'too-many-requests':
      return 'Terlalu banyak percobaan. Coba lagi beberapa saat.';
    case 'network-request-failed':
      return 'Koneksi internet bermasalah. Coba lagi.';
    case 'operation-not-allowed':
      return 'Login email/password belum diaktifkan di Firebase.';
    default:
      return 'Terjadi kesalahan. Periksa koneksi lalu coba lagi.';
  }
}

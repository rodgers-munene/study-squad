import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Login failed";
    }
  }

  Future<String> signUpWithEmail(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        return "Signup failed: no user return";
      }

      await _firestore.collection('users').doc(user.uid).set({
        "user_id": user.uid,
        "name": name,
      });

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Signup Failed";
    }
  }
}

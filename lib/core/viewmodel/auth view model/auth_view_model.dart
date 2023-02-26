import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/user.dart';

class AuthViewModel extends GetxController {
  late String name, email, password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference dbUser =
      FirebaseFirestore.instance.collection('Users');

  signInwithGoogle() async {
    try {
      final credential = await createCredential();

      final userCredential = await _auth.signInWithCredential(credential);

      final user = UserData.insertData(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
      );
      createProfile(user);
    } on PlatformException {
      rethrow;
    }
  }

  signOut() {
    _auth.signOut();
  }

  Future<OAuthCredential> createCredential() async {
    try {
      final googleAuth = await authenticationWithGoogle();
      return GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    } on PlatformException {
      rethrow;
    }
  }

  Future<GoogleSignInAuthentication> authenticationWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    return await googleUser!.authentication;
  }

  createAccount() async {
    try {
      await authenticateNewUser();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> loginAccount() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> authenticateNewUser() async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = UserData.insertData(
      id: userCredential.user!.uid,
      name: name,
      email: email,
    );
    createProfile(user);
  }

  Future<void> createProfile(UserData user) async {
    dbUser.doc(user.id).set(user.toMap());
  }
}

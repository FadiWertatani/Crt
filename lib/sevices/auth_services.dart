import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/endUser.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  EndUser _userFirebaseUser(User? firebaseUser) {
    return EndUser(uId: firebaseUser!.uid);
  }

  Future registerUser(EndUser newUser, String password) async {
    try {
      UserCredential endUserCredentials =
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: newUser.email!, password: password);
      User firebaseUser = endUserCredentials.user!;
      addUserToCollection(newUser, firebaseUser.uid);
      return _userFirebaseUser(firebaseUser);
    } catch (err, stacktrace) {
      log('user signup failed :: $err');
      log('user signup failed :: $stacktrace');
      return null;
    }
  }

  Future loginUser(String email, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (err, stacktrace) {
      log('user login failed :: $err');
      log('user login failed :: $stacktrace');
      return null;
    }
  }

  Future logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (err, stacktrace) {
      log('user login failed :: $err');
      log('user login failed :: $stacktrace');
      return null;
    }
  }

  Future updateUser(
      String userID, String fieldToChange, String valueToChange) async {
    await _firebaseFirestore.collection('users').doc(userID).update({
      fieldToChange: valueToChange,
    });
  }

  void deleteFieldInUser(String userID, String fieldToDelete) async {
    await _firebaseFirestore
        .collection('users')
        .doc(userID)
        .update({fieldToDelete: null});
  }

  Future addUserToCollection(EndUser newUser, String? uid) async {
    await _firebaseFirestore.collection('users').doc(uid).set(newUser.toJson());
  }

  Future<DocumentSnapshot> getUserData(String userID) async {
    return _firebaseFirestore.collection('users').doc(userID).get();
  }

  Stream<DocumentSnapshot> getUserDataS(String userID) {
    return _firebaseFirestore.collection('users').doc(userID).snapshots();
  }

// Future addListBusToCollection(ListBus listBus, String userId) async {
//   await _firebaseFirestore
//       .collection('listbus')
//       .doc(userId)
//       .set(listBus.toJson());
// }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Loginauthentication
{
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
}

class Authentication implements Loginauthentication
{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  Future<String> createUser(String email, String password) async {
    FirebaseUser user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }
}
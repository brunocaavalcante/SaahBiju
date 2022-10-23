import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/custom_exception.dart';

class UserService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = true;

  UserService() {
    _authChek();
  }

  _authChek() {
    auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = auth.currentUser;
    notifyListeners();
  }

  login(String email, String senha) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw CustomException('Senha incorreta. Tente novamente');
      }
    }
  }

  logout() async {
    await auth.signOut();
    _getUser();
  }
}

import 'package:blueprint/modules/current_account/current_account.entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentAccountRepository{
  Future<CurrentAccount> signupByEmail({
    required String email,
    required String password
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 3),
      );
    }

    return CurrentAccount(
      email: email,
      password: password,
    );
  }

  Future<CurrentAccount>signinByEmail({
    required String email,
    required String password,
  }) async {
    try {
    final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return CurrentAccount(
      email: res.user!.email!,
      password: password,
    );
    } catch (e, s) {
      SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 3),
      );
      print(s);
    }
    final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return CurrentAccount(
      email: res.user!.email!,
      password: password,
    );
  }
}

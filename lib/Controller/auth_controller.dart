import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Models/login_model.dart';
import 'package:firebase_login/UI/widgets/alert_dialog.dart';
import 'package:firebase_login/Models/register_model.dart';
import 'package:firebase_login/UI/widgets/loading_dialog.dart';

abstract class AuthController {
  static final _auth = FirebaseAuth.instance;

  static Future<User?> signUp(RegisterData user, BuildContext context) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.pass);
      await userCredential.user!.updateDisplayName(user.user);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          {
            alertDialog('Contraseña débil', context);
          }
          break;
        case 'email-already-in.use':
          {
            alertDialog('E-mail ya está en uso', context);
          }
          break;
        default:
          {
            alertDialog(e.code.toString(), context);
          }
          break;
      }
    }
    return null;
  }

  static Future<User?> signIn(LoginData user, BuildContext context) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.pass);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          alertDialog('El E-mail ingresado no es válido', context);
          break;
        case "wrong-password":
          alertDialog('Contraseña Incorrecta', context);
          break;
        case "user-not-found":
          alertDialog('Usuario no encontrado', context);
          break;
        case "user-disabled":
          alertDialog('El usuario está deshabilitado', context);
          break;
        case "too-many-request":
          alertDialog('Muchas peticiones en corto tiempo', context);
          break;
        case "operation-not-allowed":
          alertDialog('Operación no está permitida', context);
          break;
        default:
          alertDialog('Error Inesperado', context);
          break;
      }
    }
    return null;
  }

  static Future<void> singOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      loadingDialog(context, false);
    });
  }
}

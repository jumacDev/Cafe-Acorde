import 'package:flutter/material.dart';
import 'package:firebase_login/UI/Pages/principal_page.dart';
import 'package:firebase_login/UI/Pages/home_page.dart';

Future<void> alertDialog(
    String text, BuildContext context) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'acorde',
            style: TextStyle(
                color: Colors.orange, fontFamily: 'Arial', fontSize: 15),
          ),
          alignment: Alignment.center,
          content: SingleChildScrollView(
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () {
                if(text == 'Se ha registrado correctamente') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                }else if(text == 'Se ha iniciado sesión correctamente'){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const PrincipalPage()),
                          (route) => false);
                  }else if(text == 'Se ha cerrado la sesión'){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                          (route) => false);
                } else{
                  Navigator.pop(context);
                }
              },

              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.orange),
              ),
            )
        ]
      );
      }
  );
}

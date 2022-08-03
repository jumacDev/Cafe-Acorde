import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_login/UI/Pages/home_page.dart';
import 'package:firebase_login/UI/Pages/principal_page.dart';


Future<void> loadingDialog(BuildContext context, bool login) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
            child: SpinKitCircle(
          color: Colors.orange,
          duration: Duration(seconds: 2),
        ));
      }).whenComplete(() {
        if(login){
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const PrincipalPage()),
                  (route) => false);
        }else{
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
        }
  });
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/UI/Pages/principal_page.dart';
import 'package:firebase_login/UI/Pages/home_page.dart';
import 'package:firebase_login/UI/Pages/login_page.dart';
import 'package:firebase_login/UI/Pages/register_page.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/RegisterPage': (context) => const RegisterPage(),
        '/HomePage': (context) => const HomePage(),
        '/LoginPage': (context) => const LoginPage(),
        '/PrincipalPage': (context) => const PrincipalPage(),
      },
      initialRoute: '/HomePage',
    );
  }
}


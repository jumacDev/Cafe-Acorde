// ignore_for_file: deprecated_member_use
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String urlLogo =
      'https://firebasestorage.googleapis.com/v0/b/fir-login-a701e.appspot.com/o/acorde.png?alt=media&token=482ddb2f-40d3-4112-bab0-a28c49522b44';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text('Inicio'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image(
                image: NetworkImage(urlLogo),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/LoginPage');
                },
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.pushNamed(context, '/RegisterPage');
                },
                child: const Text('Registrarse',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

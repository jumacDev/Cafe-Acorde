import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Controller/auth_controller.dart';
import 'package:firebase_login/Models/login_model.dart';
import 'package:firebase_login/UI/widgets/alert_dialog.dart';
import 'package:firebase_login/Controller/Validations/is_valid_email.dart';
import 'package:firebase_login/UI/widgets/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Iniciar Sesión'),
          centerTitle: true,
        ),
        body: loginBody(),
      ),
    );
  }

  loginBody() {
    TextEditingController emailText = TextEditingController();
    TextEditingController passText = TextEditingController();

    String urlLogo =
        'https://firebasestorage.googleapis.com/v0/b/fir-login-a701e.appspot.com/o/acorde.png?alt=media&token=482ddb2f-40d3-4112-bab0-a28c49522b44';
    return GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: ListView(
          padding: const EdgeInsets.all((20)),
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image(
                image: NetworkImage(urlLogo),
                height: 250,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputField(
                    onChanged: (text) {
                      emailText.text = text;
                    },
                    label: "E-mail",
                    inputType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null) return null;
                      return isValidEmail(text) ? null : "E-mail Inválido";
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    onChanged: (text) {
                      passText.text = text;
                    },
                    label: "Contraseña",
                    isPassword: true,
                    validator: (text) {
                      if (text == null) return null;
                      return text.trim().length >= 8
                          ? null
                          : "Contraseña Inválida";
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange
                ),
                onPressed: () {
                  if(emailText.text != '' && passText.text != ''){
                    LoginData userData = LoginData(emailText.text, passText.text);
                    Future<User?> user = AuthController.signIn(userData, context);
                    // ignore: unnecessary_null_comparison
                    if (user != null){
                      alertDialog('Se ha iniciado sesión correctamente', context);
                    }
                  }else{
                    alertDialog('Campos Vacíos', context);
                  }
                },
                child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ));
  }
}

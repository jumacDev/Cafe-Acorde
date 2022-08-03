import 'package:firebase_login/Controller/auth_controller.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/UI/widgets/alert_dialog.dart';
import 'package:firebase_login/Models/register_model.dart';
import 'package:firebase_login/UI/widgets/custom_input_field.dart';
import 'package:firebase_login/Controller/Validations/is_valid_name.dart';
import 'package:firebase_login/Controller/Validations/is_valid_email.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Registro'),
          centerTitle: true,
        ),
        body: registerBody(),
      ),
    );
  }

  registerBody() {
    TextEditingController userText = TextEditingController();
    TextEditingController emailText = TextEditingController();
    TextEditingController passText = TextEditingController();
    String urlLogo =
        'https://firebasestorage.googleapis.com/v0/b/fir-login-a701e.appspot.com/o/acorde.png?alt=media&token=482ddb2f-40d3-4112-bab0-a28c49522b44';

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  children: [
                    CustomInputField(
                      onChanged: (text) {
                        userText.text = text;
                      },
                      label: "Usuario",
                      validator: (text) {
                        if (text == null) return null;
                        return isValidName(text) ? null : "Usuario Inválido";
                      },
                      //controller: userText,
                    ),
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
                      //controller: emailText,
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
                      //controller: passText,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        if (emailText.text != '' && userText.text != '') {
                          RegisterData userData = RegisterData(
                              userText.text, emailText.text, passText.text);
                          Future<User?> user = AuthController.signUp(userData, context);

                          // ignore: unnecessary_null_comparison
                          if (user != null) {
                            alertDialog('Se ha registrado correctamente', context);
                          }
                        } else {
                          alertDialog('Campos vacios', context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      color: Colors.orange,
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

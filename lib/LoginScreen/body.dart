import 'package:alianza_troyana/DialogBox/error_dialog.dart';
import 'package:alianza_troyana/DialogBox/loadin_dialog.dart';
import 'package:alianza_troyana/HomeScreen/home_screen.dart';
import 'package:alianza_troyana/LoginScreen/background.dart';
import 'package:alianza_troyana/SignupScreen/signup_screen.dart';
import 'package:alianza_troyana/Widgets/alredy_have_an_account_check.dart';
import 'package:alianza_troyana/Widgets/rounded_button.dart';
import 'package:alianza_troyana/Widgets/rounded_input_field.dart';
import 'package:alianza_troyana/Widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../ForgetPassword/forget_password.dart';

class LoginBody extends StatefulWidget{

@override
State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async
  {
    showDialog(context: context,
        builder: (_)
        {
          return LoadingAlertDialog(message: 'Cargando',);
        }
    );

    User? currentUser;

    await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
      ).then((auth)
        {
          currentUser = auth.user;
        }).catchError((error)
    {
      Navigator.pop(context);
      showDialog(context: context, builder: (context)
      {
        return ErrorAlertDialog(message: error.message.toString());
      });
    });
    if(currentUser != null)
      {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeScreen()));
      }else
        {
          print('ERROR');
        }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.04,),
            Image.asset('assets/images/logo.png',
              height: size.height * 0.32,
            ),
            SizedBox(height: size.height * 0.03,),
            RoundedInputField(
              hintText: 'Correo',
              icon: Icons.person,
              onChanged: (value){
                _emailController.text = value;
              },
            ),
            const SizedBox(height: 6,),
            RoundedPasswordField(
              onChanged: (value)
              {
                _passwordController.text = value;
              },
            ),
            const SizedBox(height: 8,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()));
                },
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            RoundedButton(text: 'Ingresar', press: ()
            {
              _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty
                  ? _login()
                  : showDialog(context: context,
                  builder: ( context)
              {
                return ErrorAlertDialog(message: 'Ingresa un usuario y contraseña valida');
              },
              );
            }),
            SizedBox( height: size.height * 0.03,),
            AlredyHaveAnAccountCheck(
              login: true,
              press: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}



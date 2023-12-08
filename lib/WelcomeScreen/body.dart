import 'package:flutter/material.dart';
import '../LoginScreen/login_screen.dart';
import '../SignupScreen/signup_screen.dart';
import '../Widgets/rounded_button.dart';
import 'background.dart';

class WelcomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WelcomeBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            const Text('Alianza Troyana',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Bebas',
              ),
            ),
              SizedBox(height: size.height * 0.2,),
              Image.asset('assets/images/logo.png',
              height: size.height * 0.34,
              ),
              RoundedButton(
                text: 'Iniciar Sesion',
                color:  Colors.cyan,
                press: ()
                {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              RoundedButton(
                text: 'Registrarse',
                color: Colors.cyan,
                textColor: Colors.white,
                press: ()
                {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
              ),
            ],
          ),
        ));
  }

}

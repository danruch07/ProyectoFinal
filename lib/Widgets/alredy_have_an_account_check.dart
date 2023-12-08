import 'package:flutter/material.dart';

class AlredyHaveAnAccountCheck extends StatelessWidget {

  final bool login;
  final VoidCallback press;

  AlredyHaveAnAccountCheck({
    this.login = true,
    required this.press,
});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? '¿Aun no tienes cuenta?' : 'Ya tengo cuenta',
          style: const TextStyle(color: Colors.black,
          fontStyle: FontStyle.italic),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? '  Registrate!!' : 'Iniciar Sesion',
            style: const TextStyle(
              color:  Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        )
      ],
    );
  }
}

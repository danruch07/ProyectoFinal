
import 'package:flutter/material.dart';

class  SignUpBackground extends StatelessWidget {

  final Widget child;
  SignUpBackground({
    required this.child,
});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal,],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
      ),
    height: size.height,
    width: double.infinity,
    child: Stack(
    alignment: Alignment.center,
    children:[
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset('assets/images/signup_top.png',
        color: Colors.grey.shade700,
          width: size.width * 0.3,
        ),
      ),
      Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset('assets/images/main_bottom.png',
            color: Colors.deepPurple.shade700,
            width: size.width * 0.3,
          ),
      ),
      child,
    ],
    ),
    );
  }
}

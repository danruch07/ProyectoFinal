import 'package:flutter/material.dart';

class UploadAdScreen extends StatefulWidget {

  @override
  State<UploadAdScreen> createState() => _UploadAdScreenState();
}

class _UploadAdScreenState extends State<UploadAdScreen> {

  bool next = false;

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.pink,],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: Text(
          next ? 'Describe el objeto' :'Sube fotos del objeto',
        style: const TextStyle(
          color: Colors.black54,
          fontFamily: 'Signatra',
          fontSize: 30,
        ),
      ),
        actions: [
          next ?
          Container()
              : ElevatedButton(onPressed: (){

          },
          child: const Text(
            'Siguiente',
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontFamily: 'Varela'
            ),
          )
          ),

        ],
      ),
    ),);  }
}

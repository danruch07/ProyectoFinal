import 'package:alianza_troyana/LoginScreen/login_screen.dart';
import 'package:alianza_troyana/ProfileScreen/profile_screen.dart';
import 'package:alianza_troyana/SearchProduct/search_product.dart';
import 'package:alianza_troyana/UploadAdScreen/upload_ad_screen.dart';
import 'package:alianza_troyana/WelcomeScreen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
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
          automaticallyImplyLeading: false,
          actions: [
            TextButton(onPressed: ()
            {
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.person,color: Colors.black),
            ),
            ),
            TextButton(onPressed: ()
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SearchProduct()));
            },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.search,color: Colors.black),
              ),
            ),
            TextButton(onPressed: ()
            {
              _auth.signOut().then((value){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              });
            },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.logout,color: Colors.black),
              ),
            )
          ],
          title: const Text('Inicio',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Signatra',
          fontSize: 30,
        ),),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.indigo,],
              begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
          ),
        ),
      ),
    ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Publicar',
          backgroundColor: Colors.blue,

          onPressed: ()
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UploadAdScreen()));
          },
          child: const Icon(Icons.cloud_upload_rounded, color: Colors.black,),
        ),
    ),
    );
      }
}

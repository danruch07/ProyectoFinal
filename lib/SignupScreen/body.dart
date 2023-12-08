import 'dart:io';
import 'package:alianza_troyana/DialogBox/error_dialog.dart';
import 'package:alianza_troyana/ForgetPassword/forget_password.dart';
import 'package:alianza_troyana/HomeScreen/home_screen.dart';
import 'package:alianza_troyana/LoginScreen/login_screen.dart';
import 'package:alianza_troyana/SignupScreen/background.dart';
import 'package:alianza_troyana/Widgets/alredy_have_an_account_check.dart';
import 'package:alianza_troyana/Widgets/rounded_button.dart';
import 'package:alianza_troyana/Widgets/rounded_input_field.dart';
import 'package:alianza_troyana/Widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alianza_troyana/HomeScreen/home_screen.dart';





import '../Widgets/gobal_var.dart';



class SignupBody extends StatefulWidget {

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {

  String userPhothoUrl = '';
  File? _image;
  bool _isLoading = false;

  final signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _auth =FirebaseAuth.instance;


  void _getFromCamera() async
  {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async
  {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filepath) async
  {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filepath, maxHeight: 1080, maxWidth: 1080);
    if(croppedImage != null){
      setState(() {
        _image = File(croppedImage.path);
      });
    }
  }

  void _showImageDialog()
  {
    showDialog(
        context: context,
        builder: (context)
    {
      return AlertDialog
        (title: const Text('Elige una opcion'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
          InkWell(
            onTap: ()
              {
                _getFromCamera();
              },
             child: const Row(
                children: [
                   Padding(padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                          color: Colors.blue,
                         ),
                       ),
                  Text('Camara',
                  style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  ),
            InkWell(
              onTap: ()
              {
                _getFromGallery();
              },
              child: const Row(
                children: [
                  Padding(padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                  ),
                  Text('Galeria',
                    style: TextStyle(color: Colors.blue),)
                ],
              ),
            ),
               ],
            ),
         );
          }
        );
  }

  void submitFormOnSignup() async
  {
    final isValid = signUpFormKey.currentState!.validate();
    if(isValid){
      if(_image == null){
        showDialog(context: context,
            builder: (context){
          return ErrorAlertDialog(
            message: 'Selecciona una imagen',
          );
          }
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try
          {
            await _auth.createUserWithEmailAndPassword(
                email: _emailController.text.trim().toLowerCase(),
                password: _passwordController.text.trim()
            );

            final User? user = _auth.currentUser;
            uid = user!.uid;

            final ref = FirebaseStorage.instance.ref().child('userImages').child('$uid.jpg');
            await ref.putFile(_image!);
            userPhothoUrl = await ref.getDownloadURL();
            FirebaseFirestore.instance.collection('users').doc(uid).set(
                {
              'userName': _nameController.text.trim(),
              'id': uid,
                  'userNumber': _phoneController.text.trim(),
                  'userImage': userPhothoUrl,
                  'time': DateTime.now(),
                  'status': 'approved',
            }
            );
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          catch(error)
    {
      setState(() {
        _isLoading = false;
      });
      ErrorAlertDialog(message: error.toString(),);
    }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return SignUpBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: signUpFormKey,
              child: InkWell(
                onTap: ()
                {
                  _showImageDialog();
                },
                child: CircleAvatar(
                  radius: screenWidth * 0.20,
                  backgroundColor: Colors.white24,
                  backgroundImage: _image == null
                  ? null
                      : FileImage(_image!),
                  child: _image == null
                  ? Icon(
                    Icons.camera_enhance,
                    size: screenWidth * 0.18,
                    color: Colors.black
                  )
                      :null,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02,),
            RoundedInputField(
              hintText: 'Nombre',
              icon: Icons.person,
              onChanged: (value)
              {
                _nameController.text = value;
              },
            ),
            RoundedInputField(
              hintText: 'Correo',
              icon: Icons.mail,
              onChanged: (value)
              {
                _emailController.text = value;
              },
            ),
            RoundedInputField(
              hintText: 'Telefono',
              icon: Icons.phone,
              onChanged: (value)
              {
                _phoneController.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value)
              {
                _passwordController.text = value;
              },
            ),
            const SizedBox(height: 5,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder:
                  (context) => ForgetPassword()));
                },
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            _isLoading
            ?
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: const CircularProgressIndicator(),
                  ),
                )
                :
                  RoundedButton(text:  'Ingresar'
                    , press: ()
                {
                  submitFormOnSignup();
                }),
            SizedBox(height: screenHeight * 0.03,),
            AlredyHaveAnAccountCheck(
              login: false,
              press: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

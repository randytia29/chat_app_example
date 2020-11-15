import 'package:chat_app_example/chat.dart';
import 'package:chat_app_example/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Login extends StatefulWidget {
  static const String id = 'LOGIN';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<void> loginUser() async {
    auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
          user: result.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tensor Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/logo.png'),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
                hintText: 'Enter Your Email', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => password = value,
            decoration: InputDecoration(
                hintText: 'Enter Your Password', border: OutlineInputBorder()),
          ),
          CustomButton(
            text: 'Log In',
            callback: () async {
              await loginUser();
            },
          )
        ],
      ),
    );
  }
}

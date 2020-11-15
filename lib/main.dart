import 'package:chat_app_example/chat.dart';
import 'package:chat_app_example/custom_button.dart';
import 'package:chat_app_example/login.dart';
import 'package:chat_app_example/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String id = 'HOMESCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  width: 100,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              Text(
                'Tensor Chat',
                style: TextStyle(fontSize: 40),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton(
            text: 'Log In',
            callback: () {
              Navigator.of(context).pushNamed(Login.id);
            },
          ),
          CustomButton(
            text: 'Register',
            callback: () {
              Navigator.of(context).pushNamed(Registration.id);
            },
          )
        ],
      ),
    );
  }
}

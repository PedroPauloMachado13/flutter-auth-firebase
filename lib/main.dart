import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth_firebase/screens/welcome.dart';
import 'package:flutter_auth_firebase/screens/register.dart';
import 'package:flutter_auth_firebase/screens/home.dart';
import 'package:flutter_auth_firebase/screens/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'welcome',
      routes: {
        'welcome': (context) => const WelcomePage(),
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'home': (context) => HomePage()
      },
    );
  }
}

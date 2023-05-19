import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Hero(
                tag: 'logoTag',
                child: Center(child: Text('LOGO')),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "Bem vindo ao ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                  children: [
                    TextSpan(
                      text: 'app_name.',
                      style: TextStyle(
                        color: Colors.red[200],
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Acesse sua conta para continuar!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text("Entrar"),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState?.validate() ?? false) {
                    _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    Navigator.pushNamed(context, 'home');
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        var googleUser = signInWithGoogle();
                        googleUser.then((user) {
                          var data = {
                            'email': user.user!.email,
                            'name': user.user!.displayName,
                          };
                          firestore
                              .collection('users')
                              .doc(user.user!.uid)
                              .set(data);
                          Navigator.pushNamed(context, 'home');
                        });
                      },
                      child: const Text('Google')),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var fbUser = signInWithFacebook();
                        fbUser.then((user) {
                          var data = {
                            'email': user.user!.email,
                            'name': user.user!.displayName,
                          };
                          firestore
                              .collection('users')
                              .doc(user.user!.uid)
                              .set(data);
                          Navigator.pushNamed(context, 'home');
                        });
                      },
                      child: const Text('Facebook')),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _auth.sendPasswordResetEmail(
                            email: emailController.text);
                      },
                      child: const Text('Esqueci minha senha')),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Preencha o campo email e clique no botão acima\n para receber o email de reset de senha'),
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem uma conta? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Criar conta",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, 'register')),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

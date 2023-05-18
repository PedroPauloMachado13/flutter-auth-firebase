import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_firebase/screens/register.dart';

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
                      text: 'Mappii.',
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
                    final user = _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    Navigator.pushNamed(context, 'home_screen');
                  }
                },
              ),
              const SizedBox(height: 50),
              GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
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
                  onTap: () => (context) => const RegisterPage()),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

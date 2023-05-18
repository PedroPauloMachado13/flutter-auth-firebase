import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_firebase/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              const Center(child: Text('LOGO')),
              const SizedBox(height: 10),
              const Text(
                "Cadastro",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Nome completo',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                  child: const Text("Cadastrar"),
                  onPressed: () {
                    final newUser = _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    /* [TODO: UPDATE USER DATA WITH USER NAME]
                    var data = {
                      'name': nameController.text,
                    };
                    var update =
                        firestore.collection('users').doc(newUser).set(data);
                        */
                    Navigator.pushNamed(context, 'home_screen');
                  }),
              const SizedBox(height: 50),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Já tem uma conta? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Fazer login",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                onTap: () => (context) => const LoginPage(),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

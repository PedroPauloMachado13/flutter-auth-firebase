import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/screens/register.dart';
import 'package:flutter_auth_firebase/screens/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var fullWidth = MediaQuery.of(context).size.width;
    var fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: Stack(
                  children: [
                    Positioned(
                      top: (MediaQuery.of(context).size.height * -1) / 2.5,
                      child: Container(
                        height: fullHeight * 1.2,
                        width: fullWidth,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/welcome.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 90, left: 50),
                      child: _welcomeText(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Center(
                        child: Text('LOGO'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      child: const Text("cadastre-se"),
                      onPressed: () => (context) => const RegisterPage(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      child: const Text("login"),
                      onPressed: () => (context) => const LoginPage(),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  _welcomeText() {
    return RichText(
      text: const TextSpan(
        text: "BEM VINDO AO",
        style: TextStyle(
          fontSize: 23,
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: "\nmappii.",
            style: TextStyle(
              fontSize: 51,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    String email = "", password = "";
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                email = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, password: password);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "user-not-found") {
                      print('No user found email');
                    } else if (e.code == "wrong-password") {
                      print('wrong password');
                    }
                  }
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}

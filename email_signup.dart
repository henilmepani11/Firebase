import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String email = "", password = "";
    return Scaffold(
      appBar: AppBar(title: const Text("Email"), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            icon: const Icon(Icons.arrow_forward))
      ]),
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
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == "weak-password") {
                    print("The password provided to weak");
                  } else if (e.code == 'Email-already-in-use') {
                    print("The account already");
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  @override
  State<FacebookLogin> createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  bool isLoggedIn = false;
  Map userObj = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: isLoggedIn == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(userObj["name"]),
                  Text(userObj["email"]),
                  TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            isLoggedIn = false;
                            userObj = {};
                          });
                        });
                      },
                      child: const Text("Logout"))
                ],
              )
            : Center(
                child: ElevatedButton(
                    onPressed: () {
                      FacebookAuth.instance.login(permissions: [
                        "public_profile",
                        "email"
                      ]).then((value) =>
                          FacebookAuth.instance.getUserData().then((userData) {
                            setState(() {
                              isLoggedIn = true;
                              userObj = userData;
                            });
                          }));
                    },
                    child: const Text("Login with Facebook")),
              ),
      ),
    );
  }
}

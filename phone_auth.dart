import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: PhonePractice()));
}

class PhonePractice extends StatefulWidget {
  const PhonePractice({Key? key}) : super(key: key);

  @override
  State<PhonePractice> createState() => _PhonePracticeState();
}

class _PhonePracticeState extends State<PhonePractice> {
  TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = '';
  bool codeSent = false;

  verifyPhoneNumber() async {
    verified(AuthCredential authResult) {
      auth.signInWithCredential(authResult);
    }

    verificationFailed(FirebaseAuthException authException) {}

    smsSent(String verificationId, [int? forceResendingToken]) {
      verificationId = verificationId;
      setState(() {
        codeSent = true;
      });
    }

    autoRetrievalTimeout(String verificationId1) {
      verificationId = verificationId1;
    }

    await auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  void signInWithOTP() async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(hintText: "Phone number"),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Verify Phone Number"),
          ),
          codeSent == true
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: otpController,
                        decoration:
                            const InputDecoration(hintText: "Enter OTP"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Sign In"),
                    )
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

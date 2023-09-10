import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: CrashlyticsDemo()));
}

class CrashlyticsDemo extends StatefulWidget {
  const CrashlyticsDemo({Key? key}) : super(key: key);

  @override
  State<CrashlyticsDemo> createState() => _CrashlyticsDemoState();
}

class _CrashlyticsDemoState extends State<CrashlyticsDemo> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    FirebaseCrashlytics.instance.setCustomKey("userId", "Henil");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crashlytics "), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.text.length < 3) {
                        await FirebaseCrashlytics.instance.recordError(
                          "error",
                          null,
                          reason: " a fatal error",
                          fatal: true,
                        );
                      }
                    },
                    child: const Text("tap"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseCrashlytics.instance.crash();
                    },
                    child: const Text("crash App"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:clipboard/clipboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dynamicLink = '';

  @override
  void initState() {
    super.initState();
    handleDynamicLinks();
    generateDynamicLink();
  }

  Future<String> createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://week11.page.link',
      link: Uri.parse('https://your_dynamic_link_domain.page.link/'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.week11',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.week11',
      ),
    );

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return shortDynamicLink.shortUrl.toString();
  }

  void handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      setState(() {
        dynamicLink = deepLink.toString();
      });
    }

    FirebaseDynamicLinks.instance.onLink;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Generate Dynamic Link'),
                onPressed: () {
                  generateDynamicLink();
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Dynamic Link: $dynamicLink',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      FlutterClipboard.copy(dynamicLink);
                    },
                    child: const Text("Link Copy")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void generateDynamicLink() async {
    final link = await createDynamicLink();
    setState(() {
      dynamicLink = link;
    });
  }
}

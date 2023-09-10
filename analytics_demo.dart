// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late FirebaseAnalytics analytics = FirebaseAnalytics();
//
//   void logCustomEvent() async {
//     await analytics.logEvent(
//       name: 'custom_event',
//       parameters: <String, dynamic>{
//         'param1': 'value1',
//         'param2': 'value2',
//       },
//     );
//   }
//
//   // setUserProperties
//   void setUserProperties(String name, String email) async {
//     await analytics.setDefaultEventParameters(
//       <String, dynamic>{
//         'name': name,
//         'email': email,
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Analytics Example',
//       navigatorObservers: [
//         FirebaseAnalyticsObserver(analytics: analytics),
//       ],
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Firebase Analytics Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: logCustomEvent,
//                 child: const Text('Log Custom Event'),
//               ),
//               ElevatedButton(
//                 onPressed: () =>
//                     setUserProperties('John Doe', 'johndoe@example.com'),
//                 child: const Text('Set User Properties'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

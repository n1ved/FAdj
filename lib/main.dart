import 'package:flutter/material.dart';
import 'package:ryzenadj_fluttter/screens/home.dart';
import 'package:ryzenadj_fluttter/screens/ryzenadj_Info.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/info': (context) => const RyzenAdjInfo(),
      },
      initialRoute: '/',
    ),
  );
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

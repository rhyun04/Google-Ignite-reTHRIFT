// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart'; 
// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:my_app/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // to run MyApp() class
}

class MyApp extends StatelessWidget { // means that MyApp is a widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { // to define what you want to show
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner on chrome (web)
      title: 'reTHRIFT',
      theme: ThemeData( // Add the 5 lines from here... 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 175, 188),
          foregroundColor: Colors.blueGrey,
        ),
      ),
      home: const WidgetTree(),
      //const RandomWords(), // REMOVE Scaffold
    );
  }
}

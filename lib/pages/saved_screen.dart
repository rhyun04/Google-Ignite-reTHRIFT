import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth.dart';

class SavedPage extends StatefulWidget {

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final User? user = Auth().currentUser;

  Widget _signIn_orUserWithNoSaved() {
    if (user == null){
    return 
      const Text('Please sign in to continue.');
    }
    return const Text('Oh no, you have not saved any items.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Saved'),
    ),
    body: Center(
      child: _signIn_orUserWithNoSaved()
      )

      );
}

//  child: Text(
//         isLogin? 'Register instead' : 'Login instead'
//       ),
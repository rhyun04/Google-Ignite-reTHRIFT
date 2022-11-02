import 'package:my_app/auth.dart'; //local
import 'package:my_app/pages/login_register_page.dart'; //local
import 'package:flutter/material.dart';
import 'package:my_app/pages/start_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,  
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //return HomePage();
          return const StartPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
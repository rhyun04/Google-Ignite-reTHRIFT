import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/current_location_screen.dart';
import 'package:my_app/pages/saved_screen.dart';
import 'package:my_app/pages/search_screen.dart';
import 'package:my_app/pages/user_profile.dart'; // LineIcons

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final User? user = Auth().currentUser;

  int currentIndex = 0;
  
  final screens = [
    const CurrentLocationScreen(),
    const SearchScreen(),
    SavedPage(),
    const SettingsPage()
  ];

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index){
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pinkAccent,
        iconSize: 25.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ]
        ),  
      );   
  }
}


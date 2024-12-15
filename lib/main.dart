import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/main_screen_1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200], 
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView( 
              child: MainScreen1(),
            ),
          ),
        ),
      ),
    );
  }
}

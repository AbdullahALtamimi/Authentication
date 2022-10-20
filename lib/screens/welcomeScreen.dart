import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  var myData;
  WelcomeScreen(this.myData);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome back ${myData['userName']}'),
          backgroundColor: Color(0XFFe84e3f),
        ),
      ),
    );
  }
}

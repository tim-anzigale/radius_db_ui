import 'package:flutter/material.dart';
import 'package:radius_db_ui/dashboard.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  //root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RadiusDB',
      theme: ThemeData(primarySwatch: Colors.grey,
      ),
      home: Dashboard(),
    );
  }
}
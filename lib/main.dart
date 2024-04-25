// lib/main.dart

import 'package:flutter/material.dart';
import 'user_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radius App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Radius'),
        ),
        body: UserListView(),
      ),
    );
  }
}

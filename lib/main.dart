import 'package:flutter/material.dart';
import 'user_list_view.dart';
import 'navigation_drawer.dart';
import 'header.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radius App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Radius'),
        ),
        drawer: const SideMenu(),
        body: const Column(
          children: [
            Header(), 
            Expanded(
              child: UserListView(), 
            ),
          ],
        ),
      ),
    );
  }
}

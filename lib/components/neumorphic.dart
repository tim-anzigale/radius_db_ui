import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.system, // Use system theme mode
      home: Scaffold(
        appBar: AppBar(title: Text('Neumorphism Design')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConcaveNeumorphismDesign(
                  child: Padding(padding: EdgeInsets.all(16.0), child: Text('Concave'))),
              SizedBox(height: 20),
              ConvexNeumorphismDesign(
                  child: Padding(padding: EdgeInsets.all(16.0), child: Text('Convex'))),
              SizedBox(height: 20),
              FlatNeumorphismDesign(
                  child: Padding(padding: EdgeInsets.all(16.0), child: Text('Flat'))),
              SizedBox(height: 20),
              DarkConcaveNeumorphismDesign(
                  child: Padding(padding: EdgeInsets.all(16.0), child: Text('Dark Concave'))),
              SizedBox(height: 20),
              DarkConvexNeumorphismDesign(
                  child: Padding(padding: EdgeInsets.all(16.0), child: Text('Dark Convex'))),
              SizedBox(height: 20),
              DarkFlatNeumorphismDesign(
                  child: Padding(padding: EdgeInsets.all(16.0), child: Text('Dark Flat'))),
            ],
          ),
        ),
      ),
    );
  }
}

class ConcaveNeumorphismDesign extends StatelessWidget {
  final Widget child;

  ConcaveNeumorphismDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1, 1),
          end: Alignment(1, 1),
          colors: [
            Color(0xFFE6E6E6),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Color(0xffcccccc), blurRadius: 40, offset: Offset(20, 20)),
          BoxShadow(color: Color(0xffffffff), blurRadius: 40, offset: Offset(-20, -20)),
        ],
      ),
      child: child,
    );
  }
}

class ConvexNeumorphismDesign extends StatelessWidget {
  final Widget child;

  ConvexNeumorphismDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFE6E6E6),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Color(0xffcccccc), blurRadius: 40, offset: Offset(20, 20)),
          BoxShadow(color: Color(0xffffffff), blurRadius: 40, offset: Offset(-20, -20)),
        ],
      ),
      child: child,
    );
  }
}

class FlatNeumorphismDesign extends StatelessWidget {
  final Widget child;

  FlatNeumorphismDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Color(0xffcccccc), blurRadius: 40, offset: Offset(20, 20)),
          BoxShadow(color: Color(0xffffffff), blurRadius: 40, offset: Offset(-20, -20)),
        ],
      ),
      child: child,
    );
  }
}

class DarkConcaveNeumorphismDesign extends StatelessWidget {
  final Widget child;

  DarkConcaveNeumorphismDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1, 1),
          end: Alignment(1, 1),
          colors: [
            Color(0xFF3C3C3C),
            Color(0xFF2E2E2E),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Color(0xFF1C1C1C), blurRadius: 15, spreadRadius: 1.0, offset: Offset(5, 5)),
          BoxShadow(color: Color(0xFF4E4E4E), blurRadius: 15, spreadRadius: 1.0, offset: Offset(-5, -5)),
        ],
      ),
      child: child,
    );
  }
}

class DarkConvexNeumorphismDesign extends StatelessWidget {
  final Widget child;

  DarkConvexNeumorphismDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          colors: [
            Color(0xFF2E2E2E),
            Color(0xFF3C3C3C),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Color(0xFF1C1C1C), blurRadius: 15, spreadRadius: 1.0, offset: Offset(5, 5)),
          BoxShadow(color: Color(0xFF4E4E4E), blurRadius: 15, spreadRadius: 1.0, offset: Offset(-5, -5)),
        ],
      ),
      child: child,
    );
  }
}

class DarkFlatNeumorphismDesign extends StatelessWidget {
  final Widget child;

  DarkFlatNeumorphismDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Color(0xFF1C1C1C), blurRadius: 15, spreadRadius: 1.0, offset: Offset(5, 5)),
          BoxShadow(color: Color(0xFF4E4E4E), blurRadius: 15, spreadRadius: 1.0, offset: Offset(-5, -5)),
        ],
      ),
      child: child,
    );
  }
}

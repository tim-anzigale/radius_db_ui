import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Neumorphic base color
        
      ),
      child: const Text(
        'Hello Admin',
        style: TextStyle(
          fontSize: 12.0, // Font size
          fontWeight: FontWeight.bold, // Font weight
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ConcaveNeumorphismDesign extends StatelessWidget {
  final Widget child;

  const ConcaveNeumorphismDesign({super.key, required this.child});

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

  const ConvexNeumorphismDesign({super.key, required this.child});

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

  const FlatNeumorphismDesign({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Color(0xffcccccc), blurRadius: 40, offset: Offset(20, 20)),
          BoxShadow(color: Color(0xffffffff), blurRadius: 40, offset: Offset(-20, -20)),
        ],
      ),
      child: child,
    );
  }
}
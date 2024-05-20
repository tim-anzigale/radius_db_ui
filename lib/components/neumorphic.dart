import 'package:flutter/material.dart';

class ConcaveNeumorphismDesign extends StatelessWidget {
  final Widget child;

  const ConcaveNeumorphismDesign({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, 1),
          end: const Alignment(1, 1),
          colors: theme.brightness == Brightness.dark
              ? [const Color(0xFF2E2E2E), const Color(0xFF3C3C3C)]
              : [const Color(0xFFE6E6E6), const Color(0xFFFFFFFF)],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: theme.brightness == Brightness.dark
            ? [
                const BoxShadow(color: Color(0xFF1C1C1C), blurRadius: 40, offset: Offset(20, 20)),
                const BoxShadow(color: Color(0xFF4E4E4E), blurRadius: 40, offset: Offset(-20, -20)),
              ]
            : const [
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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, -1),
          end: const Alignment(1, 1),
          colors: theme.brightness == Brightness.dark
              ? [const Color(0xFF3C3C3C), const Color(0xFF2E2E2E)]
              : [const Color(0xFFFFFFFF), const Color(0xFFE6E6E6)],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: theme.brightness == Brightness.dark
            ? [
                const BoxShadow(color: Color(0xFF1C1C1C), blurRadius: 40, offset: Offset(20, 20)),
                const BoxShadow(color: Color(0xFF4E4E4E), blurRadius: 40, offset: Offset(-20, -20)),
              ]
            : const [
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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? const Color(0xFF2E2E2E) : Colors.grey[200],
        borderRadius: BorderRadius.circular(11),
        boxShadow: theme.brightness == Brightness.dark
            ? [
                const BoxShadow(color: Color(0xFF1C1C1C), blurRadius: 40, offset: Offset(20, 20)),
                const BoxShadow(color: Color(0xFF4E4E4E), blurRadius: 40, offset: Offset(-20, -20)),
              ]
            : const [
                BoxShadow(color: Color(0xffcccccc), blurRadius: 40, offset: Offset(20, 20)),
                BoxShadow(color: Color(0xffffffff), blurRadius: 40, offset: Offset(-20, -20)),
              ],
      ),
      child: child,
    );
  }
}

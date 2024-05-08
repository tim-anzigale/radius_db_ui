import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Hello Admin 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
         
        ],
      ),
    );
  }
}
 

class CustomHeadertwo extends StatelessWidget {
  const CustomHeadertwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Subscriptions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
         
        ],
      ),
    );
  }
}



class CustomHeaderthree extends StatelessWidget {
  const CustomHeaderthree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Recent Subscriptions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
         
        ],
      ),
    );
  }
}
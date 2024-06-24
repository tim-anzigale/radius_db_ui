import 'package:flutter/material.dart';
import '../models/poles_path_class.dart';

class PolesPathView extends StatelessWidget {
  final List<PolePath> polePaths;

  const PolesPathView({Key? key, required this.polePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: polePaths.length,
            itemBuilder: (context, index) {
              final polePath = polePaths[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        polePath.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Type: ${polePath.type}'),
                      Text('Cores: ${polePath.cores}'),
                      SizedBox(height: 8),
                      Text('Utility Poles:'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: polePath.utilityPoles.map((pole) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text('${pole.name}: ${pole.location.coordinates}'),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

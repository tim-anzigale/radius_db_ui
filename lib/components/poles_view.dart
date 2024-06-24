import 'package:flutter/material.dart';
import '../models/pole_class.dart';

class PolesView extends StatelessWidget {
  final List<Pole> poles;

  const PolesView({Key? key, required this.poles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Location')),
        DataColumn(label: Text('Fiber Paths')),
        DataColumn(label: Text('Enclosures')),
      ],
      rows: poles.map((pole) {
        return DataRow(cells: [
          DataCell(Text(pole.name)),
          DataCell(Text(pole.location.coordinates.toString())),
          DataCell(Text(pole.fiberPaths.length.toString())),
          DataCell(Text(pole.enclosures.length.toString())),
        ]);
      }).toList(),
    );
  }
}

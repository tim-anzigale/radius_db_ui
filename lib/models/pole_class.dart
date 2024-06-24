// models/pole_class.dart
class Pole {
  final String id;
  final String name;
  final Location location;
  final List<dynamic> fiberPaths;
  final List<dynamic> enclosures;
  
  Pole({
    required this.id,
    required this.name,
    required this.location,
    required this.fiberPaths,
    required this.enclosures,
  });

  factory Pole.fromJson(Map<String, dynamic> json) {
    return Pole(
      id: json['_id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      fiberPaths: json['fiberPaths'] ?? [],
      enclosures: json['enclosures'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'location': location.toJson(),
      'fiberPaths': fiberPaths,
      'enclosures': enclosures,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

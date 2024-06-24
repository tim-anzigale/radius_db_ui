class PolePath {
  final String id;
  final String name;
  final String type;
  final int cores;
  final List<UtilityPole> utilityPoles;
  final List<dynamic> enclosures;

  PolePath({
    required this.id,
    required this.name,
    required this.type,
    required this.cores,
    required this.utilityPoles,
    required this.enclosures,
  });

  factory PolePath.fromJson(Map<String, dynamic> json) {
    return PolePath(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      cores: json['cores'],
      utilityPoles: (json['utilityPoles'] as List)
          .map((poleJson) => UtilityPole.fromJson(poleJson))
          .toList(),
      enclosures: json['enclosures'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'cores': cores,
      'utilityPoles': utilityPoles.map((pole) => pole.toJson()).toList(),
      'enclosures': enclosures,
    };
  }
}

class UtilityPole {
  final String id;
  final String name;
  final Location location;
  final List<dynamic> fiberPaths;
  final List<dynamic> enclosures;

  UtilityPole({
    required this.id,
    required this.name,
    required this.location,
    required this.fiberPaths,
    required this.enclosures,
  });

  factory UtilityPole.fromJson(Map<String, dynamic> json) {
    return UtilityPole(
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

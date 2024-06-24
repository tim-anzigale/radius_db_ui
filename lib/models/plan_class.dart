// plan_model.dart

class Plan {
  String id;
  String name;
  String limitStr;
  DateTime createdAt;
  DateTime updatedAt;

  Plan({
    required this.id,
    required this.name,
    required this.limitStr,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      limitStr: json['limitStr'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'limitStr': limitStr,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

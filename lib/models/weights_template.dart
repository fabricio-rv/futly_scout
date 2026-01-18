/// WeightsTemplate model for match scouting evaluation criteria.
class WeightsTemplate {
  final String id;
  final String name;
  final String positionCode;
  final String roleName;
  final Map<String, double> weightsByCriteria;
  final DateTime updatedAt;

  WeightsTemplate({
    required this.id,
    required this.name,
    required this.positionCode,
    required this.roleName,
    required this.weightsByCriteria,
    required this.updatedAt,
  });

  /// Create a copy of WeightsTemplate with optional field overrides.
  WeightsTemplate copyWith({
    String? id,
    String? name,
    String? positionCode,
    String? roleName,
    Map<String, double>? weightsByCriteria,
    DateTime? updatedAt,
  }) {
    return WeightsTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      positionCode: positionCode ?? this.positionCode,
      roleName: roleName ?? this.roleName,
      weightsByCriteria: weightsByCriteria ?? this.weightsByCriteria,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert WeightsTemplate to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'positionCode': positionCode,
      'roleName': roleName,
      'weightsByCriteria': weightsByCriteria,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Create WeightsTemplate from JSON.
  factory WeightsTemplate.fromJson(Map<String, dynamic> json) {
    return WeightsTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      positionCode: json['positionCode'] as String,
      roleName: json['roleName'] as String,
      weightsByCriteria: Map<String, double>.from(
        (json['weightsByCriteria'] as Map? ?? {}).map(
          (k, v) => MapEntry(k as String, (v as num).toDouble()),
        ),
      ),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  String toString() =>
      'WeightsTemplate(id: $id, name: $name, positionCode: $positionCode, roleName: $roleName)';
}

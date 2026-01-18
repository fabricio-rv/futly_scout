/// Player model representing a football player in the Futly Scout system.
class Player {
  final String id;
  final String name;
  final int age;
  final String photoUrl;
  final String dominantFoot;
  final String teamName;
  final String category;
  final String primaryPositionCode;
  final List<String> secondaryPositionsCodes;
  final String currentRole;
  final bool isFavorite;
  final List<String> positiveTraits;
  final List<String> negativeTraits;
  final List<Map<String, dynamic>> evolutionHistory;
  final double heightCm;
  final double weightKg;
  final String notes;

  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.photoUrl,
    required this.dominantFoot,
    required this.teamName,
    required this.category,
    required this.primaryPositionCode,
    required this.secondaryPositionsCodes,
    required this.currentRole,
    required this.isFavorite,
    required this.positiveTraits,
    required this.negativeTraits,
    required this.evolutionHistory,
    required this.heightCm,
    required this.weightKg,
    required this.notes,
  });

  /// Create a copy of Player with optional field overrides.
  Player copyWith({
    String? id,
    String? name,
    int? age,
    String? photoUrl,
    String? dominantFoot,
    String? teamName,
    String? category,
    String? primaryPositionCode,
    List<String>? secondaryPositionsCodes,
    String? currentRole,
    bool? isFavorite,
    List<String>? positiveTraits,
    List<String>? negativeTraits,
    List<Map<String, dynamic>>? evolutionHistory,
    double? heightCm,
    double? weightKg,
    String? notes,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      photoUrl: photoUrl ?? this.photoUrl,
      dominantFoot: dominantFoot ?? this.dominantFoot,
      teamName: teamName ?? this.teamName,
      category: category ?? this.category,
      primaryPositionCode: primaryPositionCode ?? this.primaryPositionCode,
      secondaryPositionsCodes:
          secondaryPositionsCodes ?? this.secondaryPositionsCodes,
      currentRole: currentRole ?? this.currentRole,
      isFavorite: isFavorite ?? this.isFavorite,
      positiveTraits: positiveTraits ?? this.positiveTraits,
      negativeTraits: negativeTraits ?? this.negativeTraits,
      evolutionHistory: evolutionHistory ?? this.evolutionHistory,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
    );
  }

  /// Convert Player to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'photoUrl': photoUrl,
      'dominantFoot': dominantFoot,
      'teamName': teamName,
      'category': category,
      'primaryPositionCode': primaryPositionCode,
      'secondaryPositionsCodes': secondaryPositionsCodes,
      'currentRole': currentRole,
      'isFavorite': isFavorite,
      'positiveTraits': positiveTraits,
      'negativeTraits': negativeTraits,
      'evolutionHistory': evolutionHistory,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'notes': notes,
    };
  }

  /// Create Player from JSON.
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      photoUrl: json['photoUrl'] as String? ?? '',
      dominantFoot: json['dominantFoot'] as String? ?? 'Destro',
      teamName: json['teamName'] as String,
      category: json['category'] as String,
      primaryPositionCode: json['primaryPositionCode'] as String,
      secondaryPositionsCodes:
          List<String>.from(json['secondaryPositionsCodes'] as List? ?? []),
      currentRole: json['currentRole'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
      positiveTraits:
          List<String>.from(json['positiveTraits'] as List? ?? []),
      negativeTraits:
          List<String>.from(json['negativeTraits'] as List? ?? []),
      evolutionHistory: List<Map<String, dynamic>>.from(
          json['evolutionHistory'] as List? ?? []),
      heightCm: (json['heightCm'] as num?)?.toDouble() ?? 0.0,
      weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0.0,
      notes: json['notes'] as String? ?? '',
    );
  }

  @override
  String toString() =>
      'Player(id: $id, name: $name, age: $age, primaryPositionCode: $primaryPositionCode, teamName: $teamName)';
}

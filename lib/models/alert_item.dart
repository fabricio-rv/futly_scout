/// AlertItem model for scout alerts/warnings about player performance.
class AlertItem {
  final String id;
  final String title;
  final String description;
  final String severity; // LOW, MEDIUM, HIGH
  final String playerId;
  final String createdAtIso;

  AlertItem({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.playerId,
    required this.createdAtIso,
  });

  /// Create a copy of AlertItem with optional field overrides.
  AlertItem copyWith({
    String? id,
    String? title,
    String? description,
    String? severity,
    String? playerId,
    String? createdAtIso,
  }) {
    return AlertItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      severity: severity ?? this.severity,
      playerId: playerId ?? this.playerId,
      createdAtIso: createdAtIso ?? this.createdAtIso,
    );
  }

  /// Convert AlertItem to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'severity': severity,
      'playerId': playerId,
      'createdAtIso': createdAtIso,
    };
  }

  /// Create AlertItem from JSON.
  factory AlertItem.fromJson(Map<String, dynamic> json) {
    return AlertItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String? ?? 'LOW',
      playerId: json['playerId'] as String,
      createdAtIso: json['createdAtIso'] as String,
    );
  }

  @override
  String toString() =>
      'AlertItem(id: $id, title: $title, severity: $severity, playerId: $playerId)';
}

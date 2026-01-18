/// ScoutEvent model representing a single action/event during match scouting.
class ScoutEvent {
  final String id;
  final String matchId;
  final String playerId;
  final String timestampIso;
  final int minute;
  final String category; // BALL, OFF_BALL, NEGATIVE
  final String actionName;
  final bool isPositive;
  final bool underPressure;
  final bool progressive;
  final bool lineBreak;
  final bool correctDecision;
  final String dominantFootUsed;
  final double pitchX;
  final double pitchY;
  final String? note;

  ScoutEvent({
    required this.id,
    required this.matchId,
    required this.playerId,
    required this.timestampIso,
    required this.minute,
    required this.category,
    required this.actionName,
    required this.isPositive,
    required this.underPressure,
    required this.progressive,
    required this.lineBreak,
    required this.correctDecision,
    required this.dominantFootUsed,
    required this.pitchX,
    required this.pitchY,
    this.note,
  });

  /// Create a copy of ScoutEvent with optional field overrides.
  ScoutEvent copyWith({
    String? id,
    String? matchId,
    String? playerId,
    String? timestampIso,
    int? minute,
    String? category,
    String? actionName,
    bool? isPositive,
    bool? underPressure,
    bool? progressive,
    bool? lineBreak,
    bool? correctDecision,
    String? dominantFootUsed,
    double? pitchX,
    double? pitchY,
    String? note,
  }) {
    return ScoutEvent(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      playerId: playerId ?? this.playerId,
      timestampIso: timestampIso ?? this.timestampIso,
      minute: minute ?? this.minute,
      category: category ?? this.category,
      actionName: actionName ?? this.actionName,
      isPositive: isPositive ?? this.isPositive,
      underPressure: underPressure ?? this.underPressure,
      progressive: progressive ?? this.progressive,
      lineBreak: lineBreak ?? this.lineBreak,
      correctDecision: correctDecision ?? this.correctDecision,
      dominantFootUsed: dominantFootUsed ?? this.dominantFootUsed,
      pitchX: pitchX ?? this.pitchX,
      pitchY: pitchY ?? this.pitchY,
      note: note ?? this.note,
    );
  }

  /// Convert ScoutEvent to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matchId': matchId,
      'playerId': playerId,
      'timestampIso': timestampIso,
      'minute': minute,
      'category': category,
      'actionName': actionName,
      'isPositive': isPositive,
      'underPressure': underPressure,
      'progressive': progressive,
      'lineBreak': lineBreak,
      'correctDecision': correctDecision,
      'dominantFootUsed': dominantFootUsed,
      'pitchX': pitchX,
      'pitchY': pitchY,
      'note': note,
    };
  }

  /// Create ScoutEvent from JSON.
  factory ScoutEvent.fromJson(Map<String, dynamic> json) {
    return ScoutEvent(
      id: json['id'] as String,
      matchId: json['matchId'] as String,
      playerId: json['playerId'] as String,
      timestampIso: json['timestampIso'] as String,
      minute: json['minute'] as int? ?? 0,
      category: json['category'] as String? ?? 'BALL',
      actionName: json['actionName'] as String,
      isPositive: json['isPositive'] as bool? ?? true,
      underPressure: json['underPressure'] as bool? ?? false,
      progressive: json['progressive'] as bool? ?? false,
      lineBreak: json['lineBreak'] as bool? ?? false,
      correctDecision: json['correctDecision'] as bool? ?? true,
      dominantFootUsed: json['dominantFootUsed'] as String? ?? 'Right',
      pitchX: (json['pitchX'] as num?)?.toDouble() ?? 0.5,
      pitchY: (json['pitchY'] as num?)?.toDouble() ?? 0.5,
      note: json['note'] as String?,
    );
  }

  @override
  String toString() =>
      'ScoutEvent(id: $id, matchId: $matchId, action: $actionName, minute: $minute, category: $category)';
}

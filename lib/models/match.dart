/// Match model representing a football match being scouted.
class Match {
  final String id;
  final String competition;
  final String teamA;
  final String teamB;
  final String dateIso;
  final String location;
  final String playerId;
  final int scoreA;
  final int scoreB;
  final bool isFinished;
  final int minutesPlayed;
  final String weightsTemplateId;

  Match({
    required this.id,
    required this.competition,
    required this.teamA,
    required this.teamB,
    required this.dateIso,
    required this.location,
    required this.playerId,
    required this.scoreA,
    required this.scoreB,
    required this.isFinished,
    required this.minutesPlayed,
    required this.weightsTemplateId,
  });

  /// Create a copy of Match with optional field overrides.
  Match copyWith({
    String? id,
    String? competition,
    String? teamA,
    String? teamB,
    String? dateIso,
    String? location,
    String? playerId,
    int? scoreA,
    int? scoreB,
    bool? isFinished,
    int? minutesPlayed,
    String? weightsTemplateId,
  }) {
    return Match(
      id: id ?? this.id,
      competition: competition ?? this.competition,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      dateIso: dateIso ?? this.dateIso,
      location: location ?? this.location,
      playerId: playerId ?? this.playerId,
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
      isFinished: isFinished ?? this.isFinished,
      minutesPlayed: minutesPlayed ?? this.minutesPlayed,
      weightsTemplateId: weightsTemplateId ?? this.weightsTemplateId,
    );
  }

  /// Convert Match to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'competition': competition,
      'teamA': teamA,
      'teamB': teamB,
      'dateIso': dateIso,
      'location': location,
      'playerId': playerId,
      'scoreA': scoreA,
      'scoreB': scoreB,
      'isFinished': isFinished,
      'minutesPlayed': minutesPlayed,
      'weightsTemplateId': weightsTemplateId,
    };
  }

  /// Create Match from JSON.
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as String,
      competition: json['competition'] as String,
      teamA: json['teamA'] as String,
      teamB: json['teamB'] as String,
      dateIso: json['dateIso'] as String,
      location: json['location'] as String,
      playerId: json['playerId'] as String,
      scoreA: json['scoreA'] as int? ?? 0,
      scoreB: json['scoreB'] as int? ?? 0,
      isFinished: json['isFinished'] as bool? ?? false,
      minutesPlayed: json['minutesPlayed'] as int? ?? 0,
      weightsTemplateId: json['weightsTemplateId'] as String,
    );
  }

  @override
  String toString() =>
      'Match(id: $id, competition: $competition, teamA: $teamA vs teamB: $teamB, playerId: $playerId, isFinished: $isFinished)';
}

import 'package:futly_scout/models/player.dart';
import 'package:futly_scout/models/match.dart';
import 'package:futly_scout/models/scout_event.dart';
import 'package:futly_scout/models/alert_item.dart';

/// Service for detecting performance alerts on players
class AlertService {
  /// Detect alerts based on recent performance trends
  List<AlertItem> detectAlerts(
    Player player,
    List<Match> recentMatches,
    Map<String, List<ScoutEvent>> eventsByMatch,
  ) {
    final alerts = <AlertItem>[];
    final now = DateTime.now();

    // Get player's recent matches (last 3)
    final playerMatches = recentMatches
        .where((m) => m.playerId == player.id)
        .toList()
        .take(3)
        .toList();

    if (playerMatches.isEmpty) {
      return alerts;
    }

    // Check for performance drop trend
    double lastRating = 8.0;
    int droppedMatches = 0;

    for (final match in playerMatches) {
      final events = eventsByMatch[match.id] ?? [];
      if (events.isEmpty) continue;

      // Simple heuristic: count positive actions
      final positiveCount =
          events.where((e) => e.isPositive).length;
      final totalCount = events.length;
      final matchRating = totalCount > 0
          ? (positiveCount / totalCount) * 10
          : 5.0;

      if (matchRating < lastRating - 1.5) {
        droppedMatches++;
      }
      lastRating = matchRating;
    }

    if (droppedMatches >= 2) {
      alerts.add(
        AlertItem(
          id: 'alert-${player.id}-${now.millisecondsSinceEpoch}',
          title: 'Queda de Desempenho',
          description:
              '${player.name} apresentou declínio em desempenho nos últimos dois jogos. Acompanhar evolução.',
          severity: 'MEDIUM',
          playerId: player.id,
          createdAtIso: now.toIso8601String(),
        ),
      );
    }

    // Check for excessive fouls
    int foulCount = 0;
    for (final match in playerMatches) {
      final events = eventsByMatch[match.id] ?? [];
      foulCount +=
          events.where((e) => e.actionName.contains('Falta')).length;
    }

    if (foulCount >= 3) {
      alerts.add(
        AlertItem(
          id: 'alert-${player.id}-fouls-${now.millisecondsSinceEpoch}',
          title: 'Excesso de Cartões',
          description:
              '${player.name} recebeu mais de 3 faltas cometidas nos últimos jogos. Avaliar padrão de comportamento.',
          severity: 'HIGH',
          playerId: player.id,
          createdAtIso: now.toIso8601String(),
        ),
      );
    }

    // Check for positive trend (opportunity for promotion)
    double avgRating = 0.0;
    for (final match in playerMatches) {
      final events = eventsByMatch[match.id] ?? [];
      if (events.isEmpty) continue;

      final positiveCount =
          events.where((e) => e.isPositive).length;
      final matchRating = positiveCount / events.length * 10;
      avgRating += matchRating;
    }

    if (playerMatches.isNotEmpty) {
      avgRating /= playerMatches.length;

      if (avgRating >= 7.5) {
        alerts.add(
          AlertItem(
            id: 'alert-${player.id}-promotion-${now.millisecondsSinceEpoch}',
            title: 'Oportunidade de Promoção',
            description:
                '${player.name} demonstra excelente forma nas últimas partidas. Pronto para escalação em time principal.',
            severity: 'LOW',
            playerId: player.id,
            createdAtIso: now.toIso8601String(),
          ),
        );
      }
    }

    return alerts;
  }
}

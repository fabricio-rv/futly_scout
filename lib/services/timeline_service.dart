import 'package:flutter/material.dart';
import 'package:futly_scout/models/scout_event.dart';

/// Timeline item for UI display
class TimelineItem {
  final int minute;
  final String action;
  final String category;
  final bool isPositive;
  final Color color;
  final String icon;
  final String? notes;

  TimelineItem({
    required this.minute,
    required this.action,
    required this.category,
    required this.isPositive,
    required this.color,
    required this.icon,
    this.notes,
  });
}

/// Service for building timeline data for UI consumption
class TimelineService {
  static const Color positiveColor = Color(0xFF4CAF50);
  static const Color negativeColor = Color(0xFFEF5350);
  static const Color ballColor = Color(0xFF2196F3);

  /// Build timeline items from scout events
  List<TimelineItem> buildTimeline(List<ScoutEvent> events) {
    final timeline = <TimelineItem>[];

    for (final event in events) {
      final color = _getColorForEvent(event);
      final icon = _getIconForEvent(event);

      timeline.add(
        TimelineItem(
          minute: event.minute,
          action: event.actionName,
          category: event.category,
          isPositive: event.isPositive,
          color: color,
          icon: icon,
          notes: event.note,
        ),
      );
    }

    // Sort by minute
    timeline.sort((a, b) => a.minute.compareTo(b.minute));

    return timeline;
  }

  /// Filter timeline by category
  List<TimelineItem> filterByCategory(
    List<TimelineItem> timeline,
    String category,
  ) {
    return timeline.where((item) => item.category == category).toList();
  }

  /// Get color for event based on type
  Color _getColorForEvent(ScoutEvent event) {
    if (event.category == 'NEGATIVE') return negativeColor;
    if (event.isPositive) return positiveColor;
    return ballColor;
  }

  /// Get icon emoji for event
  String _getIconForEvent(ScoutEvent event) {
    switch (event.actionName.toLowerCase()) {
      case 'passe curto':
      case 'passe longo/lançamento':
        return '➡️';
      case 'finalização (no alvo)':
      case 'finalização (fora)':
        return '⚽';
      case 'cruzamento':
        return '⬅️';
      case 'drible':
        return '🔄';
      case 'desarme':
      case 'interceptação':
        return '🛡️';
      case 'duelo aéreo (ganho)':
      case 'duelo aéreo (perdido)':
        return '✈️';
      case 'bloqueio':
        return '🚫';
      case 'pressão':
        return '💪';
      case 'recuperação de posse':
        return '🔙';
      case 'perda de posse':
        return '❌';
      case 'falta cometida':
        return '⚠️';
      case 'cartão amarelo':
        return '🟨';
      case 'cartão vermelho':
        return '🟥';
      case 'impedimento':
        return '📏';
      default:
        return '•';
    }
  }
}

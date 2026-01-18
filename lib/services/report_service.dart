import 'package:futly_scout/models/player.dart';
import 'package:futly_scout/models/match.dart';
import 'package:futly_scout/models/rating_breakdown.dart';
import 'package:futly_scout/models/alert_item.dart';

/// Service for generating performance reports in Portuguese
class ReportService {
  /// Generate an automatic scouting report in Portuguese
  String generateAutoReportPTBR(
    Player player,
    Match match,
    RatingBreakdown breakdown,
    List<AlertItem> alerts,
  ) {
    final StringBuffer report = StringBuffer();

    report.writeln('📋 RELATÓRIO DE AVALIAÇÃO - FUTLY SCOUT\n');
    report.writeln('═' * 50);
    report.writeln('');

    // Header
    report.writeln('👤 JOGADOR: ${player.name}');
    report.writeln('📍 POSIÇÃO: ${player.primaryPositionCode}');
    report.writeln('👕 TIME: ${player.teamName}');
    report.writeln('');

    // Match info
    report.writeln('🎯 PARTIDA: ${match.competition}');
    report.writeln('📅 DATA: ${_formatDate(match.dateIso)}');
    report.writeln('🏟️  LOCAL: ${match.location}');
    report.writeln('⏱️  MINUTOS JOGADOS: ${match.minutesPlayed}\'');
    report.writeln('PLACAR: ${match.teamA} ${match.scoreA} x ${match.scoreB} ${match.teamB}');
    report.writeln('');

    // Overall rating
    report.writeln('⭐ AVALIAÇÃO GERAL: ${breakdown.rating.toStringAsFixed(1)}/10');
    report.writeln('');

    // Category breakdown
    report.writeln('📊 ANÁLISE POR CATEGORIA:');
    report.writeln('─' * 50);
    breakdown.categoryScores.forEach((category, score) {
      final percentage = score.toStringAsFixed(1);
      final bar = _createProgressBar(score);
      report.writeln('$category: $percentage% $bar');
    });
    report.writeln('');

    // Top positive actions
    if (breakdown.topPositiveContributors.isNotEmpty) {
      report.writeln('✅ DESTAQUES POSITIVOS:');
      for (final action in breakdown.topPositiveContributors) {
        report.writeln('  • $action');
      }
      report.writeln('');
    }

    // Top negative actions
    if (breakdown.topNegativeContributors.isNotEmpty) {
      report.writeln('⚠️  PONTOS A MELHORAR:');
      for (final action in breakdown.topNegativeContributors) {
        report.writeln('  • $action');
      }
      report.writeln('');
    }

    // Player traits
    if (player.positiveTraits.isNotEmpty) {
      report.writeln('💪 CARACTERÍSTICAS POSITIVAS:');
      for (final trait in player.positiveTraits) {
        report.writeln('  • $trait');
      }
      report.writeln('');
    }

    // Alerts
    if (alerts.isNotEmpty) {
      report.writeln('🚨 ALERTAS:');
      for (final alert in alerts) {
        report.writeln('  [${alert.severity}] ${alert.title}');
        report.writeln('  → ${alert.description}');
      }
      report.writeln('');
    }

    // Summary
    report.writeln('═' * 50);
    report.writeln('📝 RESUMO EXECUTIVO:');
    report.writeln('');
    report.writeln(_generateSummaryText(player, breakdown));

    return report.toString();
  }

  /// Format date from ISO string
  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        'jan',
        'fev',
        'mar',
        'abr',
        'mai',
        'jun',
        'jul',
        'ago',
        'set',
        'out',
        'nov',
        'dez'
      ];
      return '${date.day} de ${months[date.month - 1]} de ${date.year}';
    } catch (e) {
      return isoDate;
    }
  }

  /// Create a simple progress bar for display
  String _createProgressBar(double value) {
    final filled = (value / 10.0).round();
    final empty = 10 - filled;
    return '[' + ('█' * filled) + ('░' * empty) + ']';
  }

  /// Generate summary text based on rating
  String _generateSummaryText(Player player, RatingBreakdown breakdown) {
    if (breakdown.rating >= 8.0) {
      return '${player.name} entregou uma excelente performance nesta partida. '
          'Todos os indicadores técnicos e táticos estão em alta forma. '
          'Recomenda-se acompanhamento próximo.';
    } else if (breakdown.rating >= 6.5) {
      return '${player.name} apresentou uma boa performance. '
          'Alguns pontos positivos com oportunidades de melhoria em certas áreas. '
          'Continue monitorando a evolução.';
    } else if (breakdown.rating >= 5.0) {
      return '${player.name} teve uma performance satisfatória. '
          'Alguns altos e baixos durante a partida. '
          'Focar no desenvolvimento das áreas identificadas como pontos fracos.';
    } else {
      return '${player.name} teve uma performance abaixo do esperado. '
          'Recomenda-se análise técnica específica e trabalho de ajustes. '
          'Reavaliar em próximas oportunidades.';
    }
  }
}

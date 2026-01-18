import 'package:futly_scout/models/scout_event.dart';
import 'package:futly_scout/models/weights_template.dart';
import 'package:futly_scout/models/rating_breakdown.dart';
import 'package:futly_scout/constants/app_constants.dart';

/// Service for calculating player ratings based on scout events
class RatingService {
  /// Calculate overall rating from scout events using weights template
  RatingBreakdown calculateRating(
    List<ScoutEvent> events,
    WeightsTemplate template,
    int minutesPlayed,
  ) {
    // Tally events by action type
    final Map<String, int> actionCounts = {};
    int totalPositive = 0;
    int totalNegative = 0;

    for (final event in events) {
      final action = event.actionName;
      actionCounts[action] = (actionCounts[action] ?? 0) + 1;

      if (event.isPositive && event.category != 'NEGATIVE') {
        totalPositive++;
      } else if (!event.isPositive || event.category == 'NEGATIVE') {
        totalNegative++;
      }
    }

    // Calculate category scores (0-100)
    final categoryScores = <String, double>{};

    for (final categoryEntry in AppConstants.evaluationCriteria.entries) {
      final category = categoryEntry.key;
      double score = 50.0; // Base score

      if (events.isNotEmpty) {
        final categoryWeight = _getAverageCriteriaWeight(
          template.weightsByCriteria,
          categoryEntry.value,
        );

        // Adjust score based on positive/negative ratio
        final posNegRatio = totalPositive > 0
            ? (totalPositive / (totalPositive + totalNegative))
            : 0.0;

        // Base calculation: 50 + (posNegRatio - 0.5) * 100 * weight influence
        score = 50.0 + (posNegRatio - 0.5) * 100 * (categoryWeight / 10.0);
        score = score.clamp(0.0, 100.0);
      }

      categoryScores[category] = score;
    }

    // Calculate overall rating (0-10)
    double overallRating = 5.0;
    if (categoryScores.isNotEmpty) {
      final avgScore =
          categoryScores.values.reduce((a, b) => a + b) / categoryScores.length;
      overallRating = (avgScore / 10.0).clamp(0.0, 10.0);
    }

    // Identify top contributors
    final topPositive = _getTopActions(events, true);
    final topNegative = _getTopActions(events, false);

    return RatingBreakdown(
      rating: overallRating,
      categoryScores: categoryScores,
      topPositiveContributors: topPositive,
      topNegativeContributors: topNegative,
    );
  }

  /// Get average weight for a list of criteria
  double _getAverageCriteriaWeight(
    Map<String, double> weights,
    List<String> criteria,
  ) {
    double total = 0.0;
    for (final criterion in criteria) {
      total += weights[criterion] ?? 5.0;
    }
    return total / criteria.length;
  }

  /// Get top actions (positive or negative)
  List<String> _getTopActions(List<ScoutEvent> events, bool positive) {
    final actionCounts = <String, int>{};

    for (final event in events) {
      if (positive) {
        if (event.isPositive && event.category != 'NEGATIVE') {
          actionCounts[event.actionName] =
              (actionCounts[event.actionName] ?? 0) + 1;
        }
      } else {
        if (!event.isPositive || event.category == 'NEGATIVE') {
          actionCounts[event.actionName] =
              (actionCounts[event.actionName] ?? 0) + 1;
        }
      }
    }

    final sorted = actionCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(3).map((e) => e.key).toList();
  }
}

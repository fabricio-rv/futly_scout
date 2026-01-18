/// RatingBreakdown model for player performance analysis and scoring.
class RatingBreakdown {
  final double rating;
  final Map<String, double> categoryScores;
  final List<String> topPositiveContributors;
  final List<String> topNegativeContributors;

  RatingBreakdown({
    required this.rating,
    required this.categoryScores,
    required this.topPositiveContributors,
    required this.topNegativeContributors,
  });

  /// Create a copy of RatingBreakdown with optional field overrides.
  RatingBreakdown copyWith({
    double? rating,
    Map<String, double>? categoryScores,
    List<String>? topPositiveContributors,
    List<String>? topNegativeContributors,
  }) {
    return RatingBreakdown(
      rating: rating ?? this.rating,
      categoryScores: categoryScores ?? this.categoryScores,
      topPositiveContributors:
          topPositiveContributors ?? this.topPositiveContributors,
      topNegativeContributors:
          topNegativeContributors ?? this.topNegativeContributors,
    );
  }

  /// Convert RatingBreakdown to JSON.
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'categoryScores': categoryScores,
      'topPositiveContributors': topPositiveContributors,
      'topNegativeContributors': topNegativeContributors,
    };
  }

  /// Create RatingBreakdown from JSON.
  factory RatingBreakdown.fromJson(Map<String, dynamic> json) {
    return RatingBreakdown(
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      categoryScores: Map<String, double>.from(
        (json['categoryScores'] as Map? ?? {}).map(
          (k, v) => MapEntry(k as String, (v as num).toDouble()),
        ),
      ),
      topPositiveContributors:
          List<String>.from(json['topPositiveContributors'] as List? ?? []),
      topNegativeContributors:
          List<String>.from(json['topNegativeContributors'] as List? ?? []),
    );
  }

  @override
  String toString() =>
      'RatingBreakdown(rating: $rating, categoryScores: ${categoryScores.length} items)';
}

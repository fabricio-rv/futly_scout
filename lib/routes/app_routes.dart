/// Application routing configuration for Futly Scout
class AppRoutes {
  // Route path constants
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String matchSetup = '/match-setup';
  static const String liveScout = '/live-scout';
  static const String postGameReport = '/post-game-report';
  static const String players = '/players';
  static const String playerDetail = '/player-detail';
  static const String comparison = '/comparison';
  static const String methodology = '/methodology';
  static const String register = '/register'; // ✅ Adicione esta linha

  /// Generate named route with arguments
  static String playerDetailRoute(String playerId) {
    return '$playerDetail?playerId=$playerId';
  }

  static String comparisonRoute({String? playerAId, String? playerBId}) {
    String route = comparison;
    if (playerAId != null) route += '?playerAId=$playerAId';
    if (playerBId != null) {
      route +=
          playerAId != null ? '&playerBId=$playerBId' : '?playerBId=$playerBId';
    }
    return route;
  }
}

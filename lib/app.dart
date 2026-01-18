import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/routes/app_routes.dart';
import 'package:futly_scout/screens/auth/login_screen.dart';
import 'package:futly_scout/screens/auth/register_screen.dart';
import 'package:futly_scout/screens/auth/onboarding_screen.dart';
import 'package:futly_scout/screens/home/home_screen.dart';
import 'package:futly_scout/screens/scout/match_setup_screen.dart';
import 'package:futly_scout/screens/scout/live_scout_screen.dart';
import 'package:futly_scout/screens/scout/post_game_report_screen.dart';
import 'package:futly_scout/screens/players/player_list_screen.dart';
import 'package:futly_scout/screens/players/player_detail_screen.dart';
import 'package:futly_scout/screens/comparison/comparison_screen.dart';
import 'package:futly_scout/screens/config/methodology_screen.dart';
import 'package:futly_scout/screens/shell/app_shell.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futly Scout',
      theme: AppTheme.darkTheme(),
      home: const LoginScreen(),
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.onboarding: (_) => const OnboardingScreen(),
        AppRoutes.home: (_) => const AppShell(),
        AppRoutes.matchSetup: (_) => const MatchSetupScreen(),
        AppRoutes.players: (_) => const PlayerListScreen(),
        AppRoutes.methodology: (_) => const MethodologyScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes with arguments
        switch (settings.name) {
          case AppRoutes.liveScout:
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => LiveScoutScreen(
                matchId: args?['matchId'] ?? '',
              ),
            );
          case AppRoutes.postGameReport:
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => PostGameReportScreen(
                matchId: args?['matchId'] ?? '',
              ),
            );
          case AppRoutes.playerDetail:
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => PlayerDetailScreen(
                playerId: args?['playerId'] ?? '',
              ),
            );
          case AppRoutes.comparison:
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (_) => ComparisonScreen(
                playerAId: args?['playerAId'],
                playerBId: args?['playerBId'],
              ),
            );
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

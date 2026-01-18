import 'package:futly_scout/repositories/auth/i_auth_repository.dart';
import 'package:futly_scout/repositories/auth/mock_auth_repository.dart';
import 'package:futly_scout/repositories/players/i_player_repository.dart';
import 'package:futly_scout/repositories/players/mock_player_repository.dart';
import 'package:futly_scout/repositories/matches/i_match_repository.dart';
import 'package:futly_scout/repositories/matches/mock_match_repository.dart';
import 'package:futly_scout/repositories/config/i_config_repository.dart';
import 'package:futly_scout/repositories/config/mock_config_repository.dart';

// Firebase imports (commented for later integration)
// import 'package:futly_scout/repositories/auth/firebase_auth_repository.dart';
// import 'package:futly_scout/repositories/players/firebase_player_repository.dart';
// import 'package:futly_scout/repositories/matches/firebase_match_repository.dart';
// import 'package:futly_scout/repositories/config/firebase_config_repository.dart';

/// Environment configuration for Futly Scout
/// 
/// Set [useMock] to true to use offline-first mock data (default).
/// Set [useMock] to false to use Firebase repositories (requires Firebase setup).
class AppEnvironment {
  // CRITICAL: Change this flag to switch between Mock and Firebase
  static const bool useMock = true;

  // Repository instances
  static late IAuthRepository authRepository;
  static late IPlayerRepository playerRepository;
  static late IMatchRepository matchRepository;
  static late IConfigRepository configRepository;

  /// Initialize repositories based on environment configuration
  static void initialize() {
    if (useMock) {
      // Use mock repositories for offline-first development
      authRepository = MockAuthRepository();
      playerRepository = MockPlayerRepository();
      matchRepository = MockMatchRepository();
      configRepository = MockConfigRepository();
    } else {
      // Use Firebase repositories (requires Firebase setup)
      // TODO: Uncomment when Firebase is configured
      // authRepository = FirebaseAuthRepository();
      // playerRepository = FirebasePlayerRepository();
      // matchRepository = FirebaseMatchRepository();
      // configRepository = FirebaseConfigRepository();
      throw Exception(
        'Firebase não está configurado. '
        'Defina useMock = true ou configure Firebase.',
      );
    }
  }
}

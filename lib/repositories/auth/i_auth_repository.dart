import 'package:futly_scout/models/user_profile.dart';

/// Interface for authentication repository
abstract class IAuthRepository {
  Future<UserProfile> loginWithGoogle();
  Future<UserProfile> loginWithApple();
  Future<UserProfile> loginWithEmail(String email, String password);
  Future<void> logout();
  Future<UserProfile?> getCurrentUser();
  Future<void> setOnboardingCompleted(bool done);
}

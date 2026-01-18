import 'package:futly_scout/repositories/auth/i_auth_repository.dart';
import 'package:futly_scout/models/user_profile.dart';
import 'package:futly_scout/data/mock_data.dart';

/// Mock implementation of IAuthRepository for offline-first testing
class MockAuthRepository implements IAuthRepository {
  UserProfile? _currentUser;

  @override
  Future<UserProfile> loginWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = MockData.mockUser;
    return _currentUser!;
  }

  @override
  Future<UserProfile> loginWithApple() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = MockData.mockUser;
    return _currentUser!;
  }

  @override
  Future<UserProfile> loginWithEmail(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email e senha são obrigatórios');
    }
    _currentUser = MockData.mockUser.copyWith(email: email);
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserProfile?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<void> setOnboardingCompleted(bool done) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(onboardingCompleted: done);
    }
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

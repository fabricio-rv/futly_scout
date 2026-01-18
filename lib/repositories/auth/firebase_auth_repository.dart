import 'package:futly_scout/repositories/auth/i_auth_repository.dart';
import 'package:futly_scout/models/user_profile.dart';

/// Firebase implementation of IAuthRepository (COMMENTED - Ready for future integration)
/// This implementation should be activated when Firebase is configured.
class FirebaseAuthRepository implements IAuthRepository {
  // TODO: Initialize Firebase Auth when setting up Firebase
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserProfile> loginWithGoogle() async {
    // TODO: Implement Google Sign-In with Firebase
    /*
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception('Google Sign-In cancelled');
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
      
      return _userProfileFromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception('Erro ao fazer login com Google: $e');
    }
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<UserProfile> loginWithApple() async {
    // TODO: Implement Apple Sign-In with Firebase
    /*
    try {
      final AuthorizationCredentialAppleID credential = 
          await SignInWithApple.getAppleIDCredential();
      
      final OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final AuthCredential authCredential = oauthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(authCredential);
      
      return _userProfileFromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception('Erro ao fazer login com Apple: $e');
    }
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<UserProfile> loginWithEmail(String email, String password) async {
    // TODO: Implement Email/Password Sign-In with Firebase
    /*
    try {
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return _userProfileFromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<void> logout() async {
    // TODO: Sign out from Firebase
    /*
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<UserProfile?> getCurrentUser() async {
    // TODO: Get current Firebase user
    /*
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    
    return _userProfileFromFirebaseUser(firebaseUser);
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<void> setOnboardingCompleted(bool done) async {
    // TODO: Update onboarding status in Firestore
    /*
    final user = _firebaseAuth.currentUser;
    if (user == null) return;
    
    await _firestore.collection('users').doc(user.uid).update({
      'onboardingCompleted': done,
    });
    */
    throw UnimplementedError('Firebase not configured');
  }

  // TODO: Helper method to convert Firebase user to UserProfile
  // UserProfile _userProfileFromFirebaseUser(firebase_auth.User firebaseUser) {
  //   return UserProfile(
  //     id: firebaseUser.uid,
  //     name: firebaseUser.displayName ?? 'Usuário',
  //     email: firebaseUser.email ?? '',
  //     onboardingCompleted: false,
  //     isClubMember: false,
  //   );
  // }
}

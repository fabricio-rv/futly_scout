import 'package:futly_scout/repositories/matches/i_match_repository.dart';
import 'package:futly_scout/models/match.dart';
import 'package:futly_scout/models/scout_event.dart';

/// Firebase implementation of IMatchRepository (COMMENTED - Ready for future integration)
class FirebaseMatchRepository implements IMatchRepository {
  // TODO: Initialize Firestore when Firebase is configured
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Match>> getRecentMatches() async {
    // TODO: Query recent matches from Firestore
    /*
    final snapshot = await _firestore
        .collection('matches')
        .orderBy('dateIso', descending: true)
        .limit(20)
        .get();
    
    return snapshot.docs
        .map((doc) => Match.fromJson(doc.data()))
        .toList();
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<Match?> getMatchById(String matchId) async {
    // TODO: Get match document from Firestore
    /*
    final doc = await _firestore.collection('matches').doc(matchId).get();
    if (!doc.exists) return null;
    return Match.fromJson(doc.data()!);
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<Match> createMatch(Match match) async {
    // TODO: Create match document in Firestore
    /*
    await _firestore.collection('matches').doc(match.id).set(match.toJson());
    return match;
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<void> addScoutEvent(String matchId, ScoutEvent event) async {
    // TODO: Add scout event to Firestore subcollection
    /*
    await _firestore
        .collection('matches')
        .doc(matchId)
        .collection('events')
        .doc(event.id)
        .set(event.toJson());
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<void> finishMatch(String matchId) async {
    // TODO: Update match finished status in Firestore
    /*
    await _firestore
        .collection('matches')
        .doc(matchId)
        .update({'isFinished': true});
    */
    throw UnimplementedError('Firebase not configured');
  }

  @override
  Future<List<ScoutEvent>> getMatchEvents(String matchId) async {
    // TODO: Query scout events from Firestore subcollection
    /*
    final snapshot = await _firestore
        .collection('matches')
        .doc(matchId)
        .collection('events')
        .orderBy('minute', descending: false)
        .get();
    
    return snapshot.docs
        .map((doc) => ScoutEvent.fromJson(doc.data()))
        .toList();
    */
    throw UnimplementedError('Firebase not configured');
  }
}

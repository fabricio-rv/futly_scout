import 'package:futly_scout/models/match.dart';
import 'package:futly_scout/models/scout_event.dart';

/// Interface for match data repository
abstract class IMatchRepository {
  Future<List<Match>> getRecentMatches();

  Future<Match?> getMatchById(String matchId);

  Future<Match> createMatch(Match match);

  Future<void> addScoutEvent(String matchId, ScoutEvent event);

  Future<void> finishMatch(String matchId);

  Future<List<ScoutEvent>> getMatchEvents(String matchId);
}

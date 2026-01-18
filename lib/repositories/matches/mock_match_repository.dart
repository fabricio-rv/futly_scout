import 'package:futly_scout/repositories/matches/i_match_repository.dart';
import 'package:futly_scout/models/match.dart';
import 'package:futly_scout/models/scout_event.dart';
import 'package:futly_scout/data/mock_data.dart';

/// Mock implementation of IMatchRepository for offline-first testing
class MockMatchRepository implements IMatchRepository {
  final List<Match> _matches = List.from(MockData.mockMatches);
  final Map<String, List<ScoutEvent>> _eventsByMatch = {
    'match-001': List.from(MockData.mockScoutEventsMatch001),
    'match-002': List.from(MockData.mockScoutEventsMatch002),
  };

  @override
  Future<List<Match>> getRecentMatches() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return matches sorted by date (most recent first)
    final sorted = List<Match>.from(_matches);
    sorted.sort((a, b) => DateTime.parse(b.dateIso)
        .compareTo(DateTime.parse(a.dateIso)));
    return sorted.take(10).toList();
  }

  @override
  Future<Match?> getMatchById(String matchId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _matches.firstWhere((m) => m.id == matchId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Match> createMatch(Match match) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    _matches.add(match);
    _eventsByMatch[match.id] = [];
    return match;
  }

  @override
  Future<void> addScoutEvent(String matchId, ScoutEvent event) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    if (!_eventsByMatch.containsKey(matchId)) {
      _eventsByMatch[matchId] = [];
    }
    _eventsByMatch[matchId]!.add(event);
  }

  @override
  Future<void> finishMatch(String matchId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _matches.indexWhere((m) => m.id == matchId);
    if (index != -1) {
      _matches[index] = _matches[index].copyWith(isFinished: true);
    } else {
      throw Exception('Partida não encontrada: $matchId');
    }
  }

  @override
  Future<List<ScoutEvent>> getMatchEvents(String matchId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return _eventsByMatch[matchId] ?? [];
  }
}

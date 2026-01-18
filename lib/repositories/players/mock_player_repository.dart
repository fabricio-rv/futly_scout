import 'package:futly_scout/repositories/players/i_player_repository.dart';
import 'package:futly_scout/models/player.dart';
import 'package:futly_scout/data/mock_data.dart';

/// Mock implementation of IPlayerRepository for offline-first testing
class MockPlayerRepository implements IPlayerRepository {
  final List<Player> _players = List.from(MockData.mockPlayers);

  @override
  Future<List<Player>> getPlayers({
    String? positionCode,
    int? minAge,
    int? maxAge,
    String? teamName,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    var results = List<Player>.from(_players);

    if (positionCode != null) {
      results = results
          .where((p) =>
              p.primaryPositionCode == positionCode ||
              p.secondaryPositionsCodes.contains(positionCode))
          .toList();
    }

    if (minAge != null) {
      results = results.where((p) => p.age >= minAge).toList();
    }

    if (maxAge != null) {
      results = results.where((p) => p.age <= maxAge).toList();
    }

    if (teamName != null) {
      results = results.where((p) => p.teamName == teamName).toList();
    }

    return results;
  }

  @override
  Future<Player?> getPlayerById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _players.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updatePlayer(Player player) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _players.indexWhere((p) => p.id == player.id);
    if (index != -1) {
      _players[index] = player;
    } else {
      throw Exception('Jogador não encontrado: ${player.id}');
    }
  }

  @override
  Future<void> toggleFavorite(String playerId, bool isFavorite) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _players.indexWhere((p) => p.id == playerId);
    if (index != -1) {
      _players[index] = _players[index].copyWith(isFavorite: isFavorite);
    } else {
      throw Exception('Jogador não encontrado: $playerId');
    }
  }
}

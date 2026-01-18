import 'package:futly_scout/models/player.dart';

/// Interface for player data repository
abstract class IPlayerRepository {
  Future<List<Player>> getPlayers({
    String? positionCode,
    int? minAge,
    int? maxAge,
    String? teamName,
  });

  Future<Player?> getPlayerById(String id);

  Future<void> updatePlayer(Player player);

  Future<void> toggleFavorite(String playerId, bool isFavorite);
}

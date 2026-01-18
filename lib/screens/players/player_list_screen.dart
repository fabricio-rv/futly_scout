import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/routes/app_routes.dart';

import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:futly_scout/widgets/players/player_card.dart';

/// Player list screen with filtering
class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({Key? key}) : super(key: key);

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  String? _selectedPosition;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Jogadores',
      showAppBar: false, // ✅ Remove o título do topo
      body: SafeArea(
        child: Column(
          children: [
            // Filters
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Buscar por nome...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() => _searchText = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedPosition,
                          hint: const Text('Posição'),
                          items: [
                            'GOL',
                            'ZAG',
                            'LD',
                            'LE',
                            'ALA',
                            'VOL',
                            'MC',
                            'MEI',
                            'PD',
                            'PE',
                            'SA',
                            'ATA'
                          ]
                              .map((p) => DropdownMenuItem(
                                    value: p,
                                    child: Text(p),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => _selectedPosition = value);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _selectedPosition = null;
                            _searchText = '';
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Players list
            Expanded(
              child: FutureBuilder(
                future: AppEnvironment.playerRepository.getPlayers(
                  positionCode: _selectedPosition,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var players = snapshot.data ?? [];

                  if (_searchText.isNotEmpty) {
                    players = players
                        .where((p) => p.name
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))
                        .toList();
                  }

                  if (players.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.people_outline, size: 48),
                          const SizedBox(height: 16),
                          const Text('Nenhum jogador encontrado'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => setState(() {}),
                            child: const Text('Tentar Novamente'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      final player = players[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: PlayerCard(
                          player: player,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.playerDetail,
                            arguments: {'playerId': player.id},
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

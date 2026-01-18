import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/models/scout_event.dart';
import 'package:futly_scout/routes/app_routes.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/constants/app_constants.dart';
import 'package:futly_scout/widgets/scout/pitch_widget.dart';
import 'package:futly_scout/widgets/scout/segmented_action_bar.dart';
import 'package:futly_scout/widgets/scout/action_button.dart';
import 'package:futly_scout/widgets/scout/undo_fab.dart';
import 'package:uuid/uuid.dart';

/// Live scout screen for recording match events
class LiveScoutScreen extends StatefulWidget {
  final String matchId;

  const LiveScoutScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  @override
  State<LiveScoutScreen> createState() => _LiveScoutScreenState();
}

class _LiveScoutScreenState extends State<LiveScoutScreen> {
  late String _matchId;
  late Future<void> _loadMatchFuture;
  int _minutes = 0;
  int _scoreA = 0;
  int _scoreB = 0;
  double _pitchX = 0.5;
  double _pitchY = 0.5;
  String _currentCategory = 'Com Bola';
  List<ScoutEvent> _events = [];
  bool _isFinishing = false;

  @override
  void initState() {
    super.initState();
    _matchId = widget.matchId;
    _loadMatchFuture = _loadMatch();
  }

  Future<void> _loadMatch() async {
    final match = await AppEnvironment.matchRepository.getMatchById(_matchId);
    if (match != null) {
      setState(() {
        _scoreA = match.scoreA;
        _scoreB = match.scoreB;
      });
    }
  }

  Future<void> _recordEvent(String actionName) async {
    final event = ScoutEvent(
      id: const Uuid().v4(),
      matchId: _matchId,
      playerId: '', // Will be set from match
      timestampIso: DateTime.now().toIso8601String(),
      minute: _minutes,
      category: _currentCategory == 'Negativos' ? 'NEGATIVE' : 'BALL',
      actionName: actionName,
      isPositive: _currentCategory != 'Negativos',
      underPressure: false,
      progressive: false,
      lineBreak: false,
      correctDecision: _currentCategory != 'Negativos',
      dominantFootUsed: 'Right',
      pitchX: _pitchX,
      pitchY: _pitchY,
      note: null,
    );

    setState(() {
      _events.add(event);
    });

    await AppEnvironment.matchRepository.addScoutEvent(_matchId, event);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$actionName registrado'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _finishMatch() async {
    setState(() => _isFinishing = true);
    try {
      await AppEnvironment.matchRepository.finishMatch(_matchId);
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.postGameReport,
          arguments: {'matchId': _matchId},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isFinishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final actions = AppConstants.scoutActions[_currentCategory] ?? [];

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: const Text('Live Scout'),
        backgroundColor: AppTheme.surfaceDark,
      ),
      body: Column(
        children: [
          // Timer and scoreboard
          Container(
            padding: const EdgeInsets.all(12),
            color: AppTheme.surfaceDark,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${_minutes.toString().padLeft(2, '0')}:00',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              setState(() => _minutes++);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.pause),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_scoreA',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text('x'),
                          const SizedBox(width: 16),
                          Text(
                            '$_scoreB',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            iconSize: 16,
                            onPressed: () =>
                                setState(() => _scoreA++),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.add),
                            iconSize: 16,
                            onPressed: () =>
                                setState(() => _scoreB++),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pitch
          Container(
            height: 200,
            color: const Color(0xFF1B5E20),
            child: PitchWidget(
              onLocationSelected: (x, y) {
                setState(() {
                  _pitchX = x;
                  _pitchY = y;
                });
              },
            ),
          ),

          // Category selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SegmentedActionBar(
              initialCategory: _currentCategory,
              onCategorySelected: (category) {
                setState(() => _currentCategory = category);
              },
            ),
          ),

          // Action buttons grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                for (final action in actions)
                  ActionButton(
                    label: action,
                    onTap: () => _recordEvent(action),
                  ),
              ],
            ),
          ),

          // Finish button
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: _isFinishing ? null : _finishMatch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
              ),
              child: _isFinishing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Finalizar Partida'),
            ),
          ),
        ],
      ),
      floatingActionButton: _events.isNotEmpty
          ? UndoFAB(
              onPressed: () {
                setState(() {
                  _events.removeLast();
                });
              },
            )
          : null,
    );
  }
}

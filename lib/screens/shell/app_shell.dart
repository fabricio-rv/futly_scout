import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/screens/home/home_screen.dart';
import 'package:futly_scout/screens/scout/match_setup_screen.dart';
import 'package:futly_scout/screens/players/player_list_screen.dart';
// ✅ Importação da tela de metodologia
import 'package:futly_scout/screens/config/methodology_screen.dart';
import 'package:futly_scout/widgets/common/app_scaffold.dart';

class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // ✅ Adicionada a MethodologyScreen na lista
  final List<Widget> _pages = const [
    HomeScreen(),
    MatchSetupScreen(),
    PlayerListScreen(),
    MethodologyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: '',
      showAppBar: false,
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: AppTheme.surfaceDark,
        selectedItemColor: AppTheme.successGreen,
        unselectedItemColor: AppTheme.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer_rounded),
            label: 'Scout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_rounded),
            label: 'Jogadores',
          ),
          // ✅ Novo item de Configuração
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded), // Ícone de engrenagem
            label: 'Config',
          ),
        ],
      ),
    );
  }
}

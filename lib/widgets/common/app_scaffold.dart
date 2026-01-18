import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Main scaffold widget for Futly Scout screens
class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;

  final bool showAppBar;
  final List<Widget>? actions;

  // ✅ Scaffold espera Widget
  final Widget? bottomNavigationBar;

  const AppScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.showAppBar = true,
    this.actions,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppTheme.backgroundDark,
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              elevation: 0,
              backgroundColor: AppTheme.surfaceDark,
              actions: actions,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

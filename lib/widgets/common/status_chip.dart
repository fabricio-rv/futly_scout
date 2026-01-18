import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/services/sync_service.dart';

/// Status chip showing sync state
class StatusChip extends StatelessWidget {
  final SyncState syncState;

  const StatusChip({
    Key? key,
    required this.syncState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = _getLabel();
    final color = _getColor();

    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }

  String _getLabel() {
    switch (syncState) {
      case SyncState.offline:
        return '⚫ Offline';
      case SyncState.syncing:
        return '🔄 Sincronizando...';
      case SyncState.synced:
        return '✅ Sincronizado';
    }
  }

  Color _getColor() {
    switch (syncState) {
      case SyncState.offline:
        return const Color(0xFF424242);
      case SyncState.syncing:
        return const Color(0xFFFFA726);
      case SyncState.synced:
        return const Color(0xFF4CAF50);
    }
  }
}

import 'package:rxdart/rxdart.dart';

/// Service for managing sync state in offline-first scenarios
class SyncService {
  final BehaviorSubject<SyncState> _syncStateSubject =
      BehaviorSubject.seeded(SyncState.synced);

  Stream<SyncState> get syncStateStream => _syncStateSubject.stream;

  SyncState get currentState => _syncStateSubject.value;

  /// Simulate going offline
  void setOffline() {
    _syncStateSubject.add(SyncState.offline);
  }

  /// Simulate syncing state
  void setSyncing() {
    _syncStateSubject.add(SyncState.syncing);
  }

  /// Simulate sync complete
  void setSynced() {
    _syncStateSubject.add(SyncState.synced);
  }

  /// Get human-readable status in Portuguese
  String getStatusLabel(SyncState state) {
    switch (state) {
      case SyncState.offline:
        return 'Offline';
      case SyncState.syncing:
        return 'Sincronizando...';
      case SyncState.synced:
        return 'Sincronizado';
    }
  }

  void dispose() {
    _syncStateSubject.close();
  }
}

/// Sync states
enum SyncState { offline, syncing, synced }

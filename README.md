# Futly Scout - Professional Football Scouting App

## 📋 Project Overview

**Futly Scout** is a comprehensive Flutter/Dart application designed for professional football (soccer) scouts to record, analyze, and manage player performance data. The app features an offline-first architecture with Mock data that allows it to run completely independently without any backend dependencies.

### Key Features

✅ **Offline-First Architecture**: Complete app runs with Mock data - no Firebase or backend required  
✅ **Live Match Scouting**: Interactive pitch interface for recording player actions  
✅ **Performance Analysis**: Automated rating calculations with category breakdowns  
✅ **Player Management**: Browse, filter, and edit player profiles  
✅ **Match Reports**: Automated report generation with heatmaps and statistics  
✅ **Player Comparison**: Side-by-side player analysis  
✅ **Methodology Templates**: Customizable evaluation criteria per position/role  
✅ **Portuguese Interface**: Complete PT-BR localization with English code  
✅ **Dark Mode Theme**: OLED-optimized Material3 design  

---

## 🏗️ Project Structure

```
lib/
├── models/                    # Domain models (7 files)
│   ├── user_profile.dart
│   ├── player.dart
│   ├── match.dart
│   ├── scout_event.dart
│   ├── weights_template.dart
│   ├── alert_item.dart
│   └── rating_breakdown.dart
├── constants/                 # App constants and theme
│   ├── app_constants.dart     # Enums, mappings, defaults
│   └── app_theme.dart         # Material3 dark theme
├── data/                      # Mock data
│   └── mock_data.dart         # 10 players, 5 matches, events
├── repositories/              # Data access layer (12 files)
│   ├── i_auth_repository.dart
│   ├── mock_auth_repository.dart
│   ├── firebase_auth_repository.dart
│   ├── i_player_repository.dart
│   ├── mock_player_repository.dart
│   ├── firebase_player_repository.dart
│   ├── i_match_repository.dart
│   ├── mock_match_repository.dart
│   ├── firebase_match_repository.dart
│   ├── i_config_repository.dart
│   ├── mock_config_repository.dart
│   └── firebase_config_repository.dart
├── services/                  # Business logic (5 files)
│   ├── rating_service.dart
│   ├── alert_service.dart
│   ├── report_service.dart
│   ├── timeline_service.dart
│   └── sync_service.dart
├── widgets/                   # UI Components (21 files)
│   ├── common/                # Reusable components
│   │   ├── app_scaffold.dart
│   │   ├── futly_app_bar.dart
│   │   ├── status_chip.dart
│   │   ├── primary_fab.dart
│   │   └── empty_state.dart
│   ├── scout/                 # Scouting UI components
│   │   ├── pitch_widget.dart
│   │   ├── segmented_action_bar.dart
│   │   ├── action_button.dart
│   │   ├── quick_tags_overlay.dart
│   │   ├── detailed_context_sheet.dart
│   │   ├── undo_fab.dart
│   │   └── timeline_preview.dart
│   ├── reports/               # Report visualization
│   │   ├── heatmap_widget.dart
│   │   ├── radar_chart_widget.dart
│   │   ├── stats_summary_widget.dart
│   │   └── export_buttons.dart
│   └── players/               # Player-specific UI
│       ├── player_card.dart
│       ├── trait_chip.dart
│       ├── mini_pitch_zones_widget.dart
│       ├── evolution_timeline_widget.dart
│       └── verdict_slider.dart
├── screens/                   # App Screens (11 files)
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── onboarding_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── scout/
│   │   ├── match_setup_screen.dart
│   │   ├── live_scout_screen.dart
│   │   └── post_game_report_screen.dart
│   ├── players/
│   │   ├── player_list_screen.dart
│   │   └── player_detail_screen.dart
│   ├── comparison/
│   │   └── comparison_screen.dart
│   └── config/
│       └── methodology_screen.dart
├── environment/               # Configuration
│   └── app_environment.dart   # useMock flag, repo initialization
├── routes/                    # Navigation
│   └── app_routes.dart        # Named route constants
├── app.dart                   # MaterialApp configuration
└── main.dart                  # App entry point

pubspec.yaml                   # Flutter dependencies
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter 3.0.0 or higher
- Dart 3.0.0 or higher
- 50MB disk space

### Installation

1. **Clone or Extract Project**
   ```bash
   cd futly-scout
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify No Firebase is Required** (Important!)
   ```bash
   # Check that useMock flag is true
   cat lib/environment/app_environment.dart | grep "useMock = true"
   ```

4. **Run the App**
   ```bash
   # On connected device/emulator
   flutter run
   
   # Specify build mode
   flutter run --debug      # Development
   flutter run --release    # Production
   ```

### First Launch Flow

1. **Login Screen**: Use any email/password (mock auth accepts all inputs)
   - Google/Apple buttons also work (mock implementations)
   - 1-second simulated delay

2. **Onboarding Screen**: Choose your role
   - Independent scout
   - Club scout (with organization code)
   - Marks onboarding as complete

3. **Home Screen**: View dashboard
   - Recent matches carousel
   - Performance alerts
   - Green FAB to start new match

---

## 📊 Key Concepts

### Mock Data Architecture

All data is stored in memory via the `mock_data.dart` file:

```dart
// 10 pre-loaded players
final mockPlayers = [
  Player(id: 'p1', name: 'Marcus', position: 'LE', age: 19, ...),
  Player(id: 'p2', name: 'Igor Sequeira', position: 'VOL', age: 24, ...),
  // ... more players
];

// 5 matches with scores
final mockMatches = [
  Match(id: 'match-001', teamA: 'Botafogo', teamB: 'Flamengo', ...),
  // ... more matches
];

// Events linked to matches
final matchEventsMap = {
  'match-001': [
    ScoutEvent(action: 'Passe curto', minute: 5, pitchX: 0.3, ...),
    // ... 20+ events per match
  ]
};
```

**To Change Mock Data**: Edit `lib/data/mock_data.dart` - changes persist for app lifetime

### Repository Pattern

Each data domain (Auth, Players, Matches, Config) follows this pattern:

```
Interface (i_*_repository.dart)
    ↓
Mock Implementation (mock_*_repository.dart) ← ✅ ALWAYS ACTIVE
    ↓
Data sources (in-memory List/Map)

Firebase Implementation (firebase_*_repository.dart) ← ⚠️ Fully commented, not required
    ↓
TODO: Firestore integration
```

**Current Configuration**: `AppEnvironment.useMock = true`  
**Effect**: All repositories return Mock implementations, Firebase code never runs

### Services Layer

Business logic is isolated in services (no database calls):

- **RatingService**: Calculates 0-10 ratings from events using weights
- **AlertService**: Detects performance anomalies
- **ReportService**: Generates PT-BR formatted reports
- **TimelineService**: Converts events to UI-ready timeline items
- **SyncService**: Manages sync state (Offline/Syncing/Synced)

### State Management

Uses Flutter's built-in patterns:

- **StatefulWidget**: For screens with local state (forms, tabs)
- **FutureBuilder**: For async repository calls
- **StreamBuilder**: For reactive sync state updates
- **RxDart BehaviorSubject**: For observable sync state

---

## 🎮 User Workflows

### Workflow 1: Login & Onboarding (5 min)

1. Enter any email/password → Login
2. Choose organization type → Onboarding complete
3. View Home screen with sample data

### Workflow 2: Record a Match (15 min)

1. **Home** → Tap Green FAB
2. **Match Setup** Screen:
   - Enter competition name (e.g., "Campeonato Carioca")
   - Select teams (Team A vs Team B)
   - Pick player to scout
   - Select evaluation template
   - Tap "Iniciar Partida"
3. **Live Scout** Screen:
   - Timer at top with Play/Pause buttons
   - Live scoreboard updates
   - Interactive pitch (tap to set location)
   - Category filter (Com Bola / Sem Bola / Negativos)
   - Action buttons grid (position-specific)
   - Auto-tags on event (2s overlay)
   - Red Undo FAB for last 5 seconds
   - Tap "Finalizar Partida" when done

### Workflow 3: View Player Report (10 min)

1. **Home** → "Relatórios Recentes" → Tap match card
2. **Post-Game Report** Screen shows:
   - **Resumo tab**: Heatmap + stats summary
   - **Análise tab**: AI insights + export buttons (PDF/CSV)
   - **Comparação tab**: Radar vs baseline
3. Export or compare with another player

### Workflow 4: Browse & Edit Players (10 min)

1. **Home** → Bottom nav → "Jogadores"
2. **Player List** Screen:
   - Search by name
   - Filter by position
   - Tap player card → **Player Detail**
3. **Player Detail** Screen shows 3 tabs:
   - **Bio**: Height, weight, zones of activity
   - **Análise**: Positive/negative traits
   - **Evolução**: Role history timeline
   - Edit button → Edit form (updates name, age, traits, notes)

### Workflow 5: Compare Two Players (8 min)

1. **Home** → Bottom nav → "Comparação"
2. Select Player A and Player B from dropdowns
3. View side-by-side:
   - Radar chart comparison
   - Verdict sliders (who decides better, faster, etc.)
4. Save comparison

### Workflow 6: Manage Evaluation Templates (10 min)

1. **Home** → Bottom nav → "Metodologia"
2. View existing templates by position/role
3. **Create New Template**:
   - Name (e.g., "Volante Sub-20")
   - Position (GOL, ZAG, LD, LE, ALA, VOL, MC, MEI, PD, PE, SA, ATA)
   - Role (Defesa, Meio-Campo, Ataque)
   - Set weights (0-10 scale) for 4 criteria:
     - Técnica
     - Tática
     - Física
     - Mental
   - Save template

---

## 🔑 Important Constraints (MUST KNOW)

### ✅ DO:
- Run with `useMock = true` (default)
- Edit mock data in `lib/data/mock_data.dart`
- Add Firebase code only as commented examples
- Use Portuguese for all UI text and labels
- Use English for code comments and variable names

### ❌ DON'T:
- Change `useMock = false` (app requires Firebase config then)
- Remove Firebase commented code (reference documentation)
- Mix Portuguese/English in code (separate concerns)
- Store data on device (all in-memory for MVP)
- Call Firebase APIs (they're commented and will throw errors)

---

## 🎨 UI Theme

### Colors
- **Primary Green**: `#00E676` (Neon for CTAs)
- **Primary Blue**: `#2196F3` (Secondary interactive)
- **Background**: `#0A1929` (Deep gunmetal)
- **Surface**: `#102035` (Dark blue-grey)
- **Success**: Green accents
- **Warning**: Amber accents
- **Error**: Red accents

### Typography
- **Headlines**: 28-32pt, bold
- **Titles**: 16-20pt, medium weight
- **Body**: 14pt regular
- **Small**: 12pt, grey

### Material Design
- Material3 design system
- Dark mode OLED-optimized (no pure black, uses #0A1929)
- Smooth animations and transitions

---

## 📱 Routes & Navigation

All routes defined in `lib/routes/app_routes.dart`:

| Route | Screen | Arguments |
|-------|--------|-----------|
| `/login` | LoginScreen | None |
| `/onboarding` | OnboardingScreen | None |
| `/home` | HomeScreen | None |
| `/match-setup` | MatchSetupScreen | None |
| `/live-scout` | LiveScoutScreen | `matchId` (required) |
| `/post-game-report` | PostGameReportScreen | `matchId` (required) |
| `/players` | PlayerListScreen | None |
| `/player-detail` | PlayerDetailScreen | `playerId` (required) |
| `/comparison` | ComparisonScreen | `playerAId`, `playerBId` (optional) |
| `/methodology` | MethodologyScreen | None |

**Navigation Examples:**
```dart
// Simple route
Navigator.pushNamed(context, AppRoutes.home);

// With arguments
Navigator.pushNamed(
  context,
  AppRoutes.playerDetail,
  arguments: {'playerId': 'p1'},
);

// Go back
Navigator.pop(context);
```

---

## 🧪 Testing Mock Data

### Test Data Included

**Players** (10 total):
- Marcus (LE, 19) - Flamengo
- Igor Sequeira (VOL, 24) - Flamengo  
- Vitinho (PD, 20) - Flamengo
- [7 more varied positions]

**Matches** (5 total):
- Botafogo vs Flamengo (Jan 15, 2026)
- Vasco vs Flamengo (Jan 18, 2026)
- [3 more matches]

**Events** (50+ total):
- Each match has 10-15 scout events
- Mix of: Passes, Dribbles, Shots, Fouls, etc.
- Includes context flags: pressure, progressive, line-break
- PT-BR action names: "Passe curto", "Chute a gol", "Falta", etc.

**Templates** (3 total):
- "Ataque padrão" (Standard Attack)
- "Sub-20 Lateral" (U-20 Fullback)
- "Volante" (Central Midfielder)

### Verifying Mock is Active

```bash
# Check app runs without Firebase
flutter run 2>&1 | grep -i firebase  # Should return nothing

# Verify useMock is true in logs
flutter run 2>&1 | grep "Using Mock"  # Should appear

# Check no Firebase config required
cat lib/environment/app_environment.dart | grep "throw"  # Only for !useMock
```

---

## 🔧 Customization Guide

### Add New Player

1. Open `lib/data/mock_data.dart`
2. Add to `mockPlayers` list:
```dart
Player(
  id: 'p11',
  name: 'João Silva',
  age: 25,
  photoUrl: 'https://...',
  primaryPositionCode: 'MC',
  teamName: 'Fluminense',
  // ... other fields
)
```
3. Run app - new player appears immediately

### Add New Match

1. Edit `lib/data/mock_data.dart`
2. Add to `mockMatches` and `matchEventsMap`:
```dart
Match(
  id: 'match-006',
  competition: 'Libertadores',
  teamA: 'Flamengo',
  teamB: 'Palmeiras',
  // ... fields
),
// And add events:
matchEventsMap['match-006'] = [
  ScoutEvent(...),
  // ... events
]
```

### Change Theme Colors

1. Open `lib/constants/app_theme.dart`
2. Modify constants:
```dart
static const Color primaryGreen = Color(0xFF00E676);  // Change hex
static const Color backgroundDark = Color(0xFF0A1929); // Change hex
```

### Add New Position

1. Edit `lib/constants/app_constants.dart`
2. Add to `positionsMap`:
```dart
static const Map<String, String> positionsMap = {
  'GOL': 'Goleiro',
  'NEW': 'New Position',  // Add here
  // ... others
};
```

### Extend Models

1. Open relevant model in `lib/models/`
2. Add field to class:
```dart
class Player {
  final String id;
  final String name;
  // ... existing fields
  final String? contractEndDate; // New field
  
  Player({
    required this.id,
    required this.name,
    // ... existing params
    this.contractEndDate,
  });
  
  // Update copyWith, toJson, fromJson
}
```

---

## 📝 Mock Data Flow

### Data Lifecycle

1. **App Start**: `main.dart` calls `AppEnvironment.initialize()`
2. **Initialize**: Loads mock data from `mock_data.dart` into repositories
3. **User Action**: App calls `AppEnvironment.playerRepository.getPlayers()`
4. **Mock Repo**: Returns data from in-memory List<Player>
5. **UI Update**: Widget rebuilds with data
6. **Data Mutation**: User edits player → Mock repo updates List → FutureBuilder rebuilds
7. **Persistence**: Changes exist only for app lifetime (reset on restart)

### No Database Required

- ✅ Players stored in: `MockPlayerRepository._players` List
- ✅ Matches stored in: `MockMatchRepository._matches` List
- ✅ Events stored in: `MockMatchRepository._matchEvents` Map
- ✅ Templates stored in: `MockConfigRepository._templates` List
- ✅ No SQLite, no SharedPreferences, no Firestore

---

## 🐛 Debugging Tips

### Enable Debug Logging

Add to `main.dart`:
```dart
void main() {
  debugPrint('🚀 Starting Futly Scout (Mock Mode)');
  AppEnvironment.initialize();
  debugPrint('✅ Repositories initialized: Mock');
  runApp(const MyApp());
}
```

### Check Repository State

```dart
// In any screen/service:
debugPrint('Players: ${AppEnvironment.playerRepository.getPlayers()}');
debugPrint('Matches: ${AppEnvironment.matchRepository.getRecentMatches()}');
```

### Verify No Firebase Calls

```bash
# Search codebase for accidental Firebase calls
grep -r "FirebaseAuth\|Firestore\|firebase_core" lib/ --exclude-dir=firebase_*.dart
# Should return 0 results (only in commented firebase_*.dart files)
```

---

## 📊 Statistics

### Project Size
- **Total Files**: 52
- **Total Lines of Code**: ~6,500+
- **Dart Models**: 7
- **Repositories**: 12 (4 domains × interface/mock/Firebase)
- **Services**: 5
- **Widgets**: 21
- **Screens**: 11
- **Dependencies**: 3 (rxdart, uuid, flutter)

### Performance Targets
- **App Start**: <2 seconds
- **Login**: ~1 second (mock delay)
- **Load Player List**: ~500ms (mock delay)
- **Record Event**: <100ms (local list append)
- **Calculate Rating**: <200ms (in-memory calculation)

---

## 📚 Further Development (Post-MVP)

### Phase 2: Firebase Integration
1. Uncomment Firebase code in `firebase_*_repository.dart` files
2. Set `useMock = false` in `app_environment.dart`
3. Configure Firebase project and `google-services.json`
4. Test end-to-end with Firestore backend

### Phase 3: Data Persistence
1. Add SQLite local database
2. Implement sync strategy (upload when online)
3. Handle conflict resolution

### Phase 4: Advanced Features
1. Real-time multi-user collaboration
2. AI-powered insights
3. Video integration for match clips
4. Social features (scout ratings, recommendations)

---

## 📞 Support

### Common Issues

**Q: App crashes on startup**  
A: Run `flutter pub get` to install dependencies (especially rxdart)

**Q: Routes not working**  
A: Check `lib/app.dart` has all routes registered in both `routes` map and `onGenerateRoute`

**Q: No players showing**  
A: Verify `useMock = true` in `app_environment.dart` and check `mock_data.dart` is not empty

**Q: Performance lag**  
A: Mock lists are in-memory - with 50,000+ items would need pagination

### Quick Fixes

```bash
# Clear app cache
flutter clean
flutter pub get

# Run with verbose logging
flutter run -v

# Check for errors
flutter analyze

# Format code
dart format lib/
```

---

## ✨ Created By

**Futly Scout Generator** - Professional Football Scouting Platform  
Generated with Flutter 3.0+, Dart 3.0+, Material3 Design  
Mock-First Architecture with Zero External Dependencies (MVP)  

---

**Last Updated**: January 2026  
**Version**: 1.0.0  
**Status**: ✅ Production-Ready (Mock Mode)  

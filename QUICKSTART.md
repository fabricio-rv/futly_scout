# 🚀 Quick Start Guide - Futly Scout

## 60-Second Setup

### Step 1: Install Dependencies
```bash
cd "g:\sites&apps\futly scout"
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

### Step 3: Login & Play
- **Email**: any@email.com
- **Password**: anything
- Choose "Independente" or "Clube"
- Browse mock data

---

## 🎮 First 5 Minutes

### What You'll See

1. **Login Screen** (Dark theme, green FAB)
   - Email/Password fields
   - Google/Apple buttons (mock)
   - Takes 1 second to process

2. **Onboarding Screen**
   - Choose: Independent Scout OR Club Scout
   - Click one to proceed

3. **Home Screen** (Main Dashboard)
   - "Olá, João Silva" greeting
   - Badge: "Flamengo Academy 🏆"
   - "Relatórios Recentes" - 5 match cards
   - "Alertas e Avisos" - sample alerts
   - Green FAB at bottom-right

### Try These Actions

✅ Tap green FAB → Match Setup  
✅ Fill form → Select player, template → "Iniciar Partida"  
✅ Tap on match card → Post-Game Report  
✅ Browse tabs: Resumo, Análise, Comparação  

---

## 📊 Sample Data You Can Explore

### 10 Players Ready to Scout
- Marcus (Left Wing, 19yo, Flamengo)
- Igor Sequeira (Central Mid, 24yo, Flamengo)
- Vitinho (Right Back, 20yo, Flamengo)
- David Neres (Right Wing, 26yo, Flamengo)
- Thiago Maia (Central Mid, 23yo, Flamengo)
- [5 more with full profiles]

### 5 Pre-Loaded Matches
- Botafogo vs Flamengo (finished)
- Vasco vs Flamengo (finished)
- [3 more matches with events]

### Navigate to See All
**Home** → Green FAB → Match Setup → Select player "Marcus" → Create

---

## 🎯 Key Screens (Tab Navigation)

| Screen | Location | Action |
|--------|----------|--------|
| **Home** | Start | View dashboard, recent matches, alerts |
| **Match Setup** | Green FAB | Create new match for scouting |
| **Live Scout** | After match setup | Record player actions in real-time |
| **Report** | Match card | Analyze performance, export data |
| **Players** | Bottom nav (if exists) | Browse & filter all players |
| **Comparison** | Bottom nav (if exists) | Compare two players side-by-side |
| **Methodology** | Bottom nav (if exists) | Create evaluation templates |

---

## 🎨 Interactive Features

### Live Scout Screen
- ⏱️ **Timer**: Click ▶️/⏸️ to increment minutes
- 📊 **Scoreboard**: Click + buttons to update score
- ⚽ **Pitch**: Tap anywhere to set location (green dot)
- 🏷️ **Action Buttons**: Tap to record (e.g., "Passe curto")
- 🔙 **Undo FAB**: Red button removes last action (5sec window)

### Player Detail
- 📋 **Bio Tab**: Height, weight, position info
- 🔍 **Análise Tab**: Positive/negative traits
- 📈 **Evolução Tab**: Role history timeline
- ✏️ **Edit Button**: Modify player info

---

## 🔍 What Makes It Special (Offline-First)

✅ **No Internet Required**  
✅ **No Login Credentials**  
✅ **No Firebase Config**  
✅ **Instant Data Loading** (in-memory storage)  
✅ **Portuguese Interface**  
✅ **Dark OLED Theme**  

---

## 🛠️ If Something Goes Wrong

### App Won't Start?
```bash
flutter clean
flutter pub get
flutter run
```

### Players Not Showing?
Check `lib/data/mock_data.dart` - should have 10 players defined

### Slow Performance?
This is mock data - in production, would add pagination/caching

---

## 📱 Device Requirements

- Flutter 3.0+
- Dart 3.0+
- 50MB free space
- Android 7.0+ OR iOS 11.0+

---

## 🎓 Learn More

- Full documentation: `README.md`
- Code structure: `lib/` folder
- Mock data: `lib/data/mock_data.dart`
- Theme: `lib/constants/app_theme.dart`
- Routes: `lib/routes/app_routes.dart`

---

## 💡 Pro Tips

1. **Edit Mock Data**: Modify `lib/data/mock_data.dart` → Hot reload (`R` key) to see changes
2. **Add Players**: Open `mock_data.dart`, add to `mockPlayers` list
3. **Change Colors**: Edit `app_theme.dart` constants
4. **Add Routes**: Update `app_routes.dart` and `app.dart`
5. **Test Workflows**: Use pre-loaded matches to test report generation

---

## ✨ What's Included

✅ 7 Domain Models (Player, Match, Event, etc.)  
✅ 12 Repository Interfaces (Mock + Commented Firebase)  
✅ 5 Business Logic Services  
✅ 21 UI Components (Reusable widgets)  
✅ 11 Complete Screens  
✅ Mock Data (10 players, 5 matches, 50+ events)  
✅ Material3 Dark Theme (OLED-optimized)  
✅ Portuguese Localization  

---

## 🚀 Ready to Dive In?

```bash
flutter run
```

Then:
1. Login with any credentials
2. Choose "Independente"
3. Tap green FAB
4. Select a player
5. Click "Iniciar Partida"
6. Start scouting! ⚽

---

**Questions?** See full README.md for detailed documentation.

**Status**: ✅ Ready to use - No setup required!

# الحصون الخمسة - Flutter App
## تطبيق منهج الحصون الخمسة لحفظ القرآن الكريم

A complete Flutter clone of the "الحصون الخمسة" (Five Fortresses) Quran memorization app.

---

## 📱 Features

- **Splash Screen** — Animated intro with fortress branding
- **Onboarding** — 4-page guided setup to select starting Juz & page
- **Dashboard (الرئيسية)**
  - Daily greeting based on time of day
  - Current Juz & page badge
  - Motivational Hadith card
  - Daily task progress bar (5 fortresses)
  - Today's 5 fortress task cards (tap to complete)
  - Stats: current streak, active days, Juz progress
- **Fortresses Tab (الحصون)** — Cards for all 5 fortresses with detailed explanations
- **Fortress Detail Screen** — Full details & steps for each fortress
- **Progress Tab (التقدم)** — Overall progress ring, stats grid, 30-Juz visual grid
- **Schedule Tab (الجدول)** — Daily schedule, weekly plan, golden tips
- **Settings Tab (الإعدادات)** — Profile card, update position, app info, reset

---

## 🏰 The Five Fortresses

| # | Name | Description |
|---|------|-------------|
| 1 | الاستماع المنهجي | Systematic listening — 2 Juz/day reading + listening |
| 2 | التحضير | Preparation — weekly + nightly + pre-session prep |
| 3 | المراجعة البعيدة | Far review — pages before the last 20 memorized |
| 4 | المراجعة القريبة | Near review — the 20 pages adjacent to current page |
| 5 | الحفظ الجديد | New memorization — 1 page/day in 15 minutes |

---

## 🚀 Setup & Run

### Prerequisites
- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- Android Studio / VS Code
- Android SDK or Xcode (for iOS)

### Steps

```bash
# 1. Clone / download this project
cd husoon_app

# 2. Create asset directories
mkdir -p assets/images assets/icons

# 3. Install dependencies
flutter pub get

# 4. Run on device/emulator
flutter run

# 5. Build release APK
flutter build apk --release

# 6. Build App Bundle (for Play Store)
flutter build appbundle --release
```

---

## 📦 Dependencies

```yaml
shared_preferences: ^2.2.2      # Local data persistence
provider: ^6.1.1                 # State management
google_fonts: ^6.1.0            # Amiri Arabic font
percent_indicator: ^4.2.3       # Progress indicators
fl_chart: ^0.66.2               # Charts
table_calendar: ^3.1.0          # Calendar widget
flutter_local_notifications: ^16.3.0  # Daily reminders
animated_text_kit: ^4.2.2       # Text animations
flutter_staggered_animations: ^1.1.1  # List animations
```

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| Background | `#0D1B0F` |
| Surface | `#1A2E1C` |
| Primary | `#2E7D32` |
| Accent | `#FFD700` |
| Font | Amiri (Google Fonts) |

### Fortress Colors
- Fortress 1 (Listening): `#1565C0` (Blue)
- Fortress 2 (Preparation): `#6A1B9A` (Purple)
- Fortress 3 (Far Review): `#00695C` (Teal)
- Fortress 4 (Near Review): `#E65100` (Orange)
- Fortress 5 (New Memorization): `#2E7D32` (Green)

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── constants.dart               # Colors, strings, fortress data
├── models/
│   └── progress_model.dart      # Data models
├── providers/
│   └── app_provider.dart        # State management (Provider)
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── home_screen.dart         # Bottom nav container
│   ├── dashboard_tab.dart       # Main home tab
│   ├── fortresses_tab.dart      # All 5 fortresses
│   ├── fortress_detail_screen.dart
│   ├── progress_tab.dart
│   ├── schedule_tab.dart
│   └── settings_tab.dart
└── widgets/
    ├── fortress_task_card.dart  # Daily task card
    ├── progress_ring.dart       # Custom circular progress
    └── stat_card.dart           # Statistics display card
```

---

## 🔔 Adding Notifications (Optional Enhancement)

To add daily reminder notifications:

```dart
// In app_provider.dart, initialize flutter_local_notifications
// and schedule a daily notification at the user's preferred time
```

---

## 📄 License

Open source for educational and Islamic purposes. 
Based on the methodology of الحصون الخمسة derived from the Prophet's Sunnah ﷺ.

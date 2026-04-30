import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/progress_model.dart';

class AppProvider extends ChangeNotifier {
  ProgressModel _progress = ProgressModel();
  bool _isFirstLaunch = true;
  bool _isDarkMode = true;
  DailyRecord? _todayRecord;
  final Map<int, bool> _todayTasks = {1: false, 2: false, 3: false, 4: false, 5: false};

  ProgressModel get progress => _progress;
  bool get isFirstLaunch => _isFirstLaunch;
  bool get isDarkMode => _isDarkMode;
  DailyRecord? get todayRecord => _todayRecord;
  Map<int, bool> get todayTasks => _todayTasks;

  AppProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstLaunch = prefs.getBool('first_launch') ?? true;
    _isDarkMode = prefs.getBool('dark_mode') ?? true;

    final progressJson = prefs.getString('progress');
    if (progressJson != null) {
      try {
        _progress = ProgressModel.fromJson(json.decode(progressJson));
      } catch (_) {
        _progress = ProgressModel();
      }
    }

    // Load today tasks
    final today = _todayKey();
    for (int i = 1; i <= 5; i++) {
      _todayTasks[i] = prefs.getBool('${today}_task_$i') ?? false;
    }

    notifyListeners();
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}_${now.month}_${now.day}';
  }

  Future<void> completeOnboarding({
    required int startingJuz,
    required int startingPage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
    _isFirstLaunch = false;
    _progress = ProgressModel(
      currentJuz: startingJuz,
      currentPage: startingPage,
      startDate: DateTime.now(),
    );
    await _saveProgress();
    notifyListeners();
  }

  Future<void> toggleTask(int fortressNumber, bool value) async {
    _todayTasks[fortressNumber] = value;
    final prefs = await SharedPreferences.getInstance();
    final today = _todayKey();
    await prefs.setBool('${today}_task_$fortressNumber', value);

    // Update streak if all tasks done
    if (_todayTasks.values.every((v) => v)) {
      await _updateStreak();
    }
    notifyListeners();
  }

  Future<void> _updateStreak() async {
    final now = DateTime.now();
    final last = _progress.lastActiveDate;
    final daysDiff = now.difference(DateTime(last.year, last.month, last.day)).inDays;

    if (daysDiff == 1) {
      _progress.currentStreak++;
    } else if (daysDiff > 1) {
      _progress.currentStreak = 1;
    }
    _progress.totalDaysActive++;
    _progress.lastActiveDate = now;
    await _saveProgress();
  }

  Future<void> advancePage() async {
    if (_progress.currentPage < 604) {
      _progress.currentPage++;
      if (_progress.currentPage % 20 == 1) {
        _progress.currentJuz = ((_progress.currentPage - 1) ~/ 20) + 1;
      }
      await _saveProgress();
      notifyListeners();
    }
  }

  Future<void> setCurrentPage(int page, int juz) async {
    _progress.currentPage = page;
    _progress.currentJuz = juz;
    await _saveProgress();
    notifyListeners();
  }

  Future<void> markJuzCompleted(int juz) async {
    _progress.completedJuz[juz] = true;
    await _saveProgress();
    notifyListeners();
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('progress', json.encode(_progress.toJson()));
  }

  int get completedTasksToday => _todayTasks.values.where((v) => v).length;
  double get todayProgressPercent => completedTasksToday / 5.0;

  String get motivationalQuote {
    final quotes = [
      '"خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ"',
      '"اقْرَءُوا الْقُرْآنَ فَإِنَّهُ يَأْتِي يَوْمَ الْقِيَامَةِ شَفِيعًا لِأَصْحَابِهِ"',
      '"تَعَاهَدُوا هَذَا الْقُرْآنَ فَوَالَّذِي نَفْسُ مُحَمَّدٍ بِيَدِهِ لَهُوَ أَشَدُّ تَفَلُّتًا مِنَ الإِبِلِ فِي عُقُلِهَا"',
      '"الَّذِي يَقْرَأُ الْقُرْآنَ وَهُوَ مَاهِرٌ بِهِ مَعَ السَّفَرَةِ الْكِرَامِ الْبَرَرَةِ"',
    ];
    return quotes[DateTime.now().day % quotes.length];
  }
}

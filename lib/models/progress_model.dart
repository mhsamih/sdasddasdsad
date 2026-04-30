class ProgressModel {
  int currentJuz; // 1-30
  int currentPage; // 1-604
  int currentFortress; // 1-5
  Map<int, bool> completedJuz; // juz number -> completed
  List<DailyRecord> dailyRecords;
  int totalDaysActive;
  int currentStreak;
  DateTime startDate;
  DateTime lastActiveDate;

  ProgressModel({
    this.currentJuz = 1,
    this.currentPage = 1,
    this.currentFortress = 1,
    Map<int, bool>? completedJuz,
    List<DailyRecord>? dailyRecords,
    this.totalDaysActive = 0,
    this.currentStreak = 0,
    DateTime? startDate,
    DateTime? lastActiveDate,
  })  : completedJuz = completedJuz ?? {},
        dailyRecords = dailyRecords ?? [],
        startDate = startDate ?? DateTime.now(),
        lastActiveDate = lastActiveDate ?? DateTime.now();

  double get overallProgress => (currentPage - 1) / 604;
  double get juzProgress => ((currentJuz - 1) * 20 + (currentPage % 20)) / 604;

  Map<String, dynamic> toJson() => {
        'currentJuz': currentJuz,
        'currentPage': currentPage,
        'currentFortress': currentFortress,
        'completedJuz': completedJuz.map((k, v) => MapEntry(k.toString(), v)),
        'totalDaysActive': totalDaysActive,
        'currentStreak': currentStreak,
        'startDate': startDate.toIso8601String(),
        'lastActiveDate': lastActiveDate.toIso8601String(),
        'dailyRecords': dailyRecords.map((r) => r.toJson()).toList(),
      };

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
        currentJuz: json['currentJuz'] ?? 1,
        currentPage: json['currentPage'] ?? 1,
        currentFortress: json['currentFortress'] ?? 1,
        completedJuz: (json['completedJuz'] as Map<String, dynamic>?)
                ?.map((k, v) => MapEntry(int.parse(k), v as bool)) ??
            {},
        totalDaysActive: json['totalDaysActive'] ?? 0,
        currentStreak: json['currentStreak'] ?? 0,
        startDate: json['startDate'] != null
            ? DateTime.parse(json['startDate'])
            : DateTime.now(),
        lastActiveDate: json['lastActiveDate'] != null
            ? DateTime.parse(json['lastActiveDate'])
            : DateTime.now(),
        dailyRecords: (json['dailyRecords'] as List<dynamic>?)
                ?.map((r) => DailyRecord.fromJson(r))
                .toList() ??
            [],
      );
}

class DailyRecord {
  final DateTime date;
  final bool listeningDone;
  final bool preparationDone;
  final bool farReviewDone;
  final bool nearReviewDone;
  final bool newMemorizationDone;
  final int minutesSpent;

  DailyRecord({
    required this.date,
    this.listeningDone = false,
    this.preparationDone = false,
    this.farReviewDone = false,
    this.nearReviewDone = false,
    this.newMemorizationDone = false,
    this.minutesSpent = 0,
  });

  bool get allDone =>
      listeningDone &&
      preparationDone &&
      farReviewDone &&
      nearReviewDone &&
      newMemorizationDone;

  int get completedCount => [
        listeningDone,
        preparationDone,
        farReviewDone,
        nearReviewDone,
        newMemorizationDone
      ].where((b) => b).length;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'listeningDone': listeningDone,
        'preparationDone': preparationDone,
        'farReviewDone': farReviewDone,
        'nearReviewDone': nearReviewDone,
        'newMemorizationDone': newMemorizationDone,
        'minutesSpent': minutesSpent,
      };

  factory DailyRecord.fromJson(Map<String, dynamic> json) => DailyRecord(
        date: DateTime.parse(json['date']),
        listeningDone: json['listeningDone'] ?? false,
        preparationDone: json['preparationDone'] ?? false,
        farReviewDone: json['farReviewDone'] ?? false,
        nearReviewDone: json['nearReviewDone'] ?? false,
        newMemorizationDone: json['newMemorizationDone'] ?? false,
        minutesSpent: json['minutesSpent'] ?? 0,
      );
}

class FortressTask {
  final int fortressNumber;
  final String title;
  final String description;
  bool isCompleted;
  final int targetMinutes;

  FortressTask({
    required this.fortressNumber,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.targetMinutes,
  });
}

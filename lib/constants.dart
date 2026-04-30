import 'package:flutter/material.dart';

class AppColors {
  // Primary palette – deep forest green / gold Islamic
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color accent = Color(0xFFFFD700);
  static const Color accentLight = Color(0xFFFFE57F);
  static const Color background = Color(0xFF0D1B0F);
  static const Color surface = Color(0xFF1A2E1C);
  static const Color surfaceLight = Color(0xFF243828);
  static const Color cardBg = Color(0xFF1E3320);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textGold = Color(0xFFFFD700);
  static const Color divider = Color(0xFF2E4D30);
  static const Color success = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFEF5350);

  // Fortress colors
  static const List<Color> fortressColors = [
    Color(0xFF1565C0), // 1 - Listening - blue
    Color(0xFF6A1B9A), // 2 - Preparation - purple
    Color(0xFF00695C), // 3 - Far review - teal
    Color(0xFFE65100), // 4 - Near review - orange
    Color(0xFF2E7D32), // 5 - New memorization - green
  ];
}

class AppStrings {
  static const String appName = 'الحصون الخمسة';
  static const String appSubtitle = 'منهج متكامل لحفظ القرآن الكريم';

  static const List<Map<String, dynamic>> fortresses = [
    {
      'number': '١',
      'title': 'الاستماع المنهجي',
      'subtitle': 'الحصن الأول',
      'description':
          'قراءة القرآن الكريم لمدة شهرين بمعدل جزأين يومياً مع الاستماع المنتظم',
      'icon': '🎧',
      'details': [
        'قراءة جزأين يومياً (ختمة كل نصف شهر)',
        'القراءة المتأنية مع الفهم والتدبر',
        'الاستماع لتلاوة كاملة لجزء يومياً',
        'مراعاة أحكام التجويد والترتيل',
        'ألا تتجاوز قراءة الجزأين 40 دقيقة',
      ],
    },
    {
      'number': '٢',
      'title': 'التحضير',
      'subtitle': 'الحصن الثاني',
      'description':
          'مرحلة التهيئة والإعداد قبل الحفظ لتثبيت الآيات في الذاكرة',
      'icon': '📖',
      'details': [
        'التحضير الأسبوعي: قراءة 7 صفحات من الجزء المراد حفظه',
        'تحضير الليلة: تكرار صفحة الحفظ 15 دقيقة قبل النوم',
        'الاستماع للمنشاوي 15 دقيقة أو 10 مرات',
        'التحضير القبلي: قراءة الصفحة 15 مرة بطريقة التلقي',
      ],
    },
    {
      'number': '٣',
      'title': 'المراجعة البعيدة',
      'subtitle': 'الحصن الثالث',
      'description': 'مراجعة الصفحات المحفوظة بعد العشرين صفحة التالية للحفظ',
      'icon': '🔄',
      'details': [
        'مراجعة ما قبل العشرين صفحة من بداية الحفظ',
        'تنشيط الذاكرة بشكل مستمر ومنتظم',
        'تعزيز الحفظ القديم مع تقدم الحفظ الجديد',
        'المراجعة بطريقة الحدر السريع',
      ],
    },
    {
      'number': '٤',
      'title': 'المراجعة القريبة',
      'subtitle': 'الحصن الرابع',
      'description': 'مراجعة العشرين صفحة التي تبدأ من صفحة الحفظ',
      'icon': '📝',
      'details': [
        'مراجعة العشرين صفحة المجاورة لصفحة الحفظ الجديد',
        'الحفظ يومياً مع مراجعة السابق',
        'تكوين العشرين صفحة بشكل تدريجي',
        'الحفاظ على نشاط الحفظ بشكل دائم',
      ],
    },
    {
      'number': '٥',
      'title': 'الحفظ الجديد',
      'subtitle': 'الحصن الخامس',
      'description': 'حفظ الجزء الجديد بهدف يومي ثابت بمعدل 15 دقيقة',
      'icon': '⭐',
      'details': [
        'حفظ صفحة جديدة يومياً بمعدل 15 دقيقة',
        'مراعاة أحكام التجويد والترتيل',
        'التدبر في معاني الآيات',
        'الالتزام بالهدف اليومي بانتظام',
      ],
    },
  ];

  static const List<String> juzNames = [
    'الجزء الأول - الم', 'الجزء الثاني - سَيَقُولُ',
    'الجزء الثالث - تِلْكَ الرُّسُلُ', 'الجزء الرابع - لَنْ تَنَالُوا',
    'الجزء الخامس - وَالْمُحْصَنَاتُ', 'الجزء السادس - لَا يُحِبُّ اللَّهُ',
    'الجزء السابع - وَإِذَا سَمِعُوا', 'الجزء الثامن - وَلَوْ أَنَّنَا',
    'الجزء التاسع - قَالَ الْمَلَأُ', 'الجزء العاشر - وَاعْلَمُوا',
    'الجزء الحادي عشر - يَعْتَذِرُونَ', 'الجزء الثاني عشر - وَمَا مِنْ دَابَّةٍ',
    'الجزء الثالث عشر - وَمَا أُبَرِّئُ', 'الجزء الرابع عشر - رُبَمَا',
    'الجزء الخامس عشر - سُبْحَانَ الَّذِي', 'الجزء السادس عشر - قَالَ أَلَمْ',
    'الجزء السابع عشر - اقْتَرَبَ', 'الجزء الثامن عشر - قَدْ أَفْلَحَ',
    'الجزء التاسع عشر - وَقَالَ الَّذِينَ', 'الجزء العشرون - أَمَّنْ خَلَقَ',
    'الجزء الحادي والعشرون - اتْلُ مَا أُوحِيَ', 'الجزء الثاني والعشرون - وَمَنْ يَقْنُطُ',
    'الجزء الثالث والعشرون - وَمَا لِيَ', 'الجزء الرابع والعشرون - فَمَنْ أَظْلَمُ',
    'الجزء الخامس والعشرون - إِلَيْهِ يُرَدُّ', 'الجزء السادس والعشرون - حم',
    'الجزء السابع والعشرون - قَالَ فَمَا خَطْبُكُمْ', 'الجزء الثامن والعشرون - قَدْ سَمِعَ',
    'الجزء التاسع والعشرون - تَبَارَكَ الَّذِي', 'الجزء الثلاثون - عَمَّ',
  ];
}

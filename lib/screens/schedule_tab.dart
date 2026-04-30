import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/app_provider.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (ctx, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text(
              'الجدول اليومي',
              style: TextStyle(
                  color: AppColors.textPrimary, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDailySchedule(provider),
                const SizedBox(height: 20),
                _buildWeeklyPlan(),
                const SizedBox(height: 20),
                _buildTips(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDailySchedule(AppProvider provider) {
    final scheduleItems = [
      {
        'time': 'قبل الفجر',
        'task': 'الاستماع لتلاوة الجزء المراد حفظه',
        'duration': '15 دقيقة',
        'fortress': 1,
        'icon': '🌙',
      },
      {
        'time': 'بعد الفجر',
        'task': 'التحضير القبلي - قراءة صفحة الحفظ 15 مرة',
        'duration': '15 دقيقة',
        'fortress': 2,
        'icon': '📖',
      },
      {
        'time': 'الضحى',
        'task': 'الحفظ الجديد',
        'duration': '15 دقيقة',
        'fortress': 5,
        'icon': '⭐',
      },
      {
        'time': 'الظهر',
        'task': 'المراجعة القريبة (20 صفحة)',
        'duration': '20 دقيقة',
        'fortress': 4,
        'icon': '📝',
      },
      {
        'time': 'العصر',
        'task': 'المراجعة البعيدة',
        'duration': '15 دقيقة',
        'fortress': 3,
        'icon': '🔄',
      },
      {
        'time': 'قبل النوم',
        'task': 'تحضير الليلة - قراءة صفحة الغد',
        'duration': '15 دقيقة',
        'fortress': 2,
        'icon': '🌜',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'البرنامج اليومي المقترح',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...scheduleItems.map((item) => _buildScheduleItem(item)),
      ],
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> item) {
    final color = AppColors.fortressColors[(item['fortress'] as int) - 1];
    final isDone = false; // Could be tracked

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Text(item['icon'] as String, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['time'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['duration'] as String,
                        style: TextStyle(fontSize: 11, color: color),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['task'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخطة الأسبوعية',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              _buildWeekItem('السبت - الثلاثاء', 'التحضير الأسبوعي (7 صفحات من الجزء القادم)', AppColors.fortressColors[1]),
              const Divider(color: AppColors.divider),
              _buildWeekItem('الأربعاء - الجمعة', 'مراجعة المحفوظ + استئناف الحفظ الجديد', AppColors.fortressColors[4]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeekItem(String days, String task, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(days,
                    style: TextStyle(fontSize: 12, color: color)),
                Text(task,
                    style: TextStyle(
                        fontSize: 14, color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTips() {
    final tips = [
      'احرص على الانتظام اليومي ولا تتخطى يوماً',
      'استمع للمنشاوي رحمه الله خصيصاً',
      'اجعل وقت الحفظ ثابتاً كل يوم',
      'لا تزد على صفحة واحدة حتى تتقن المنهج',
      'التكرار سر التثبيت في الذاكرة',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نصائح ذهبية',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...tips.asMap().entries.map(
          (e) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Text(
                  '💡',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

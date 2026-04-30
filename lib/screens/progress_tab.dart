import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/app_provider.dart';
import '../widgets/progress_ring.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (ctx, provider, _) {
        final progress = provider.progress;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text('تقدم الحفظ',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverallProgress(progress),
                const SizedBox(height: 20),
                _buildStatsGrid(provider),
                const SizedBox(height: 20),
                Text(
                  'خريطة الأجزاء',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildJuzGrid(provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverallProgress(progress) {
    final percent = ((progress.currentPage - 1) / 604 * 100).toStringAsFixed(1);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.3),
            AppColors.primaryDark.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ProgressRing(
            progress: (progress.currentPage - 1) / 604,
            size: 100,
            strokeWidth: 10,
            centerText: '$percent%',
            fontSize: 16,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التقدم الكلي',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                _infoRow('الجزء الحالي', '${progress.currentJuz} / 30'),
                _infoRow('الصفحة الحالية', '${progress.currentPage} / 604'),
                _infoRow(
                    'الأجزاء المكتملة',
                    '${progress.completedJuz.values.where((v) => v).length}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primaryLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(AppProvider provider) {
    final progress = provider.progress;
    final stats = [
      {
        'label': 'أيام النشاط',
        'value': '${progress.totalDaysActive}',
        'icon': Icons.calendar_today,
        'color': AppColors.fortressColors[0],
      },
      {
        'label': 'الإنجاز الأسبوعي',
        'value': '${(provider.completedTasksToday / 5 * 100).toInt()}%',
        'icon': Icons.trending_up,
        'color': AppColors.fortressColors[2],
      },
      {
        'label': 'أيام متتالية',
        'value': '${progress.currentStreak}',
        'icon': Icons.local_fire_department,
        'color': Colors.orange,
      },
      {
        'label': 'الصفحات المحفوظة',
        'value': '${progress.currentPage - 1}',
        'icon': Icons.menu_book,
        'color': AppColors.accent,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: stats.length,
      itemBuilder: (_, i) {
        final stat = stats[i];
        final color = stat['color'] as Color;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(stat['icon'] as IconData, color: color, size: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stat['value'] as String,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    stat['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJuzGrid(AppProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: 30,
      itemBuilder: (_, i) {
        final juzNumber = i + 1;
        final isCurrent = juzNumber == provider.progress.currentJuz;
        final isCompleted =
            provider.progress.completedJuz[juzNumber] ?? false;
        final isPast = juzNumber < provider.progress.currentJuz;

        Color bgColor;
        Color borderColor;
        Color textColor;

        if (isCompleted) {
          bgColor = AppColors.primary.withOpacity(0.3);
          borderColor = AppColors.primary;
          textColor = AppColors.primaryLight;
        } else if (isCurrent) {
          bgColor = AppColors.accent.withOpacity(0.2);
          borderColor = AppColors.accent;
          textColor = AppColors.accent;
        } else if (isPast) {
          bgColor = AppColors.primary.withOpacity(0.1);
          borderColor = AppColors.primary.withOpacity(0.3);
          textColor = AppColors.textSecondary;
        } else {
          bgColor = AppColors.cardBg;
          borderColor = AppColors.divider;
          textColor = AppColors.textSecondary;
        }

        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: isCurrent ? 2 : 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCompleted)
                Icon(Icons.check, color: AppColors.primaryLight, size: 16)
              else
                Text(
                  '$juzNumber',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              Text(
                'ج',
                style: TextStyle(fontSize: 10, color: textColor),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/app_provider.dart';
import '../widgets/fortress_task_card.dart';
import '../widgets/progress_ring.dart';
import '../widgets/stat_card.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (ctx, provider, _) {
        return CustomScrollView(
          slivers: [
            _buildAppBar(provider),
            SliverToBoxAdapter(child: _buildQuoteCard(provider)),
            SliverToBoxAdapter(child: _buildTodayProgress(provider)),
            SliverToBoxAdapter(child: _buildStatsRow(provider)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text(
                  'مهام اليوم',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FortressTaskCard(
                  fortressIndex: i,
                  isCompleted: provider.todayTasks[i + 1] ?? false,
                  onToggle: (val) => provider.toggleTask(i + 1, val),
                ),
                childCount: 5,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }

  Widget _buildAppBar(AppProvider provider) {
    return SliverAppBar(
      expandedHeight: 180,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primaryDark,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.primaryDark,
                AppColors.primary.withOpacity(0.8),
                AppColors.background,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الحصون الخمسة',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            _getGreeting(),
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      ProgressRing(
                        progress: provider.todayProgressPercent,
                        size: 70,
                        strokeWidth: 6,
                        centerText:
                            '${provider.completedTasksToday}/5',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildCurrentPositionBadge(provider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPositionBadge(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark, color: AppColors.accent, size: 16),
          const SizedBox(width: 6),
          Text(
            'الجزء ${provider.progress.currentJuz}  •  صفحة ${provider.progress.currentPage}',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(AppProvider provider) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.primaryDark.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            provider.motivationalQuote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.accent,
              height: 1.8,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'صدق رسول الله ﷺ',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayProgress(AppProvider provider) {
    final completed = provider.completedTasksToday;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تقدم اليوم',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$completed / 5 مهام',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: completed / 5,
              minHeight: 8,
              backgroundColor: AppColors.divider,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              5,
              (i) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 28,
                  decoration: BoxDecoration(
                    color: (provider.todayTasks[i + 1] ?? false)
                        ? AppColors.fortressColors[i]
                        : AppColors.divider,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (provider.todayTasks[i + 1] ?? false)
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: StatCard(
              icon: Icons.local_fire_department,
              iconColor: Colors.orange,
              title: '${provider.progress.currentStreak}',
              subtitle: 'يوم متتالي',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatCard(
              icon: Icons.menu_book_rounded,
              iconColor: AppColors.accent,
              title: '${provider.progress.currentJuz}',
              subtitle: 'الجزء الحالي',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatCard(
              icon: Icons.check_circle,
              iconColor: AppColors.success,
              title: '${provider.progress.totalDaysActive}',
              subtitle: 'أيام نشطة',
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'أسهر مع القرآن 🌙';
    if (hour < 12) return 'صباح النور 🌅';
    if (hour < 17) return 'بارك الله في وقتك ☀️';
    if (hour < 21) return 'مساء الخير 🌇';
    return 'سهرة مباركة 🌙';
  }
}

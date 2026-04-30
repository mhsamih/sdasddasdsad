import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/app_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (ctx, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text(
              'الإعدادات',
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
                _buildProfileCard(provider),
                const SizedBox(height: 20),
                _buildSectionTitle('إعدادات التقدم'),
                _buildUpdatePositionCard(context, provider),
                const SizedBox(height: 20),
                _buildSectionTitle('حول التطبيق'),
                _buildAboutSection(),
                const SizedBox(height: 20),
                _buildResetCard(context, provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(AppProvider provider) {
    final completedJuz =
        provider.progress.completedJuz.values.where((v) => v).length;
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
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: const Center(
              child: Text('📖', style: TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'حافظ القرآن',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem('${provider.progress.currentStreak}', 'يوم متتالي'),
              _statItem('$completedJuz', 'جزء محفوظ'),
              _statItem('${provider.progress.currentPage - 1}', 'صفحة'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        Text(label,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildUpdatePositionCard(BuildContext context, AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'موضع الحفظ الحالي',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'الجزء ${provider.progress.currentJuz}  •  صفحة ${provider.progress.currentPage}',
            style: TextStyle(color: AppColors.primaryLight, fontSize: 14),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showUpdateDialog(context, provider),
              icon: const Icon(Icons.edit),
              label: const Text('تعديل الموضع'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryLight,
                side: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, AppProvider provider) {
    int selectedJuz = provider.progress.currentJuz;
    int selectedPage = provider.progress.currentPage;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text('تحديث الموضع',
              style: TextStyle(color: AppColors.textPrimary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogDropdown<int>(
                label: 'الجزء',
                value: selectedJuz,
                items: List.generate(
                    30,
                    (i) => DropdownMenuItem(
                        value: i + 1, child: Text('الجزء ${i + 1}'))),
                onChanged: (v) {
                  setState(() {
                    selectedJuz = v!;
                    selectedPage = (selectedJuz - 1) * 20 + 1;
                  });
                },
              ),
              const SizedBox(height: 12),
              _buildDialogDropdown<int>(
                label: 'الصفحة',
                value: selectedPage,
                items: List.generate(
                    20,
                    (i) => DropdownMenuItem(
                        value: (selectedJuz - 1) * 20 + i + 1,
                        child:
                            Text('صفحة ${(selectedJuz - 1) * 20 + i + 1}'))),
                onChanged: (v) => setState(() => selectedPage = v!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('إلغاء',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () {
                provider.setCurrentPage(selectedPage, selectedJuz);
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary),
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          dropdownColor: AppColors.surface,
          style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    final items = [
      {'icon': Icons.info_outline, 'label': 'إصدار التطبيق', 'value': '1.0.0'},
      {'icon': Icons.book_outlined, 'label': 'المنهج', 'value': 'الحصون الخمسة'},
      {
        'icon': Icons.person_outline,
        'label': 'المصدر',
        'value': 'السنة النبوية الشريفة'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final item = entry.value;
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              ListTile(
                leading: Icon(item['icon'] as IconData,
                    color: AppColors.primaryLight),
                title: Text(item['label'] as String,
                    style: TextStyle(color: AppColors.textPrimary)),
                trailing: Text(item['value'] as String,
                    style: TextStyle(color: AppColors.textSecondary)),
              ),
              if (!isLast) Divider(color: AppColors.divider, height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildResetCard(BuildContext context, AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚠️ منطقة الخطر',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'إعادة ضبط التطبيق ستحذف جميع بياناتك وتقدمك',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _confirmReset(context, provider),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error),
              ),
              child: const Text('إعادة الضبط'),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title:
            Text('تأكيد الإعادة', style: TextStyle(color: AppColors.error)),
        content: Text(
          'هل أنت متأكد؟ سيتم حذف جميع بيانات التقدم.',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إلغاء',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              provider.completeOnboarding(startingJuz: 1, startingPage: 1);
              Navigator.pop(ctx);
              Navigator.of(context).pushReplacementNamed('/onboarding');
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('إعادة الضبط'),
          ),
        ],
      ),
    );
  }
}

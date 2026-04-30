import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedJuz = 1;
  int _selectedPage = 1;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: '📖',
      title: 'مرحباً بك في\nالحصون الخمسة',
      description:
          'منهج متكامل لحفظ القرآن الكريم المستمد من السنة النبوية الشريفة',
      color: AppColors.primary,
    ),
    _OnboardingPage(
      icon: '🏰',
      title: 'خمسة حصون\nللحفظ المتقن',
      description:
          'يعتمد المنهج على خمس خطوات منهجية ومتواصلة توصل إلى حفظ القرآن كاملاً في وقت قصير',
      color: AppColors.fortressColors[1],
    ),
    _OnboardingPage(
      icon: '⏱️',
      title: 'هدف يومي\n١٥ دقيقة',
      description:
          'بالالتزام بهدف يومي ثابت لا يتجاوز ١٥ دقيقة يمكنك إتمام حفظ القرآن الكريم كاملاً',
      color: AppColors.fortressColors[3],
    ),
    _OnboardingPage(
      icon: '🎯',
      title: 'حدد نقطة\nالبداية',
      description: 'اختر الجزء والصفحة التي ستبدأ منها رحلة حفظك للقرآن الكريم',
      color: AppColors.accent,
      isSetup: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _startApp();
    }
  }

  Future<void> _startApp() async {
    await context.read<AppProvider>().completeOnboarding(
          startingJuz: _selectedJuz,
          startingPage: _selectedPage,
        );
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemCount: _pages.length,
              itemBuilder: (ctx, i) => _buildPage(_pages[i]),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildPage(_OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page.color.withOpacity(0.15),
              border: Border.all(color: page.color.withOpacity(0.3), width: 2),
            ),
            child: Center(
              child: Text(page.icon, style: const TextStyle(fontSize: 52)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
          if (page.isSetup) ...[
            const SizedBox(height: 40),
            _buildSetupWidget(),
          ],
        ],
      ),
    );
  }

  Widget _buildSetupWidget() {
    return Column(
      children: [
        _buildDropdown(
          label: 'الجزء',
          value: _selectedJuz,
          items: List.generate(
              30, (i) => DropdownMenuItem(value: i + 1, child: Text('الجزء ${i + 1}'))),
          onChanged: (v) => setState(() {
            _selectedJuz = v!;
            _selectedPage = (_selectedJuz - 1) * 20 + 1;
          }),
        ),
        const SizedBox(height: 16),
        _buildDropdown(
          label: 'الصفحة',
          value: _selectedPage,
          items: List.generate(
              20,
              (i) => DropdownMenuItem(
                  value: (_selectedJuz - 1) * 20 + i + 1,
                  child: Text('صفحة ${(_selectedJuz - 1) * 20 + i + 1}'))),
          onChanged: (v) => setState(() => _selectedPage = v!),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          dropdownColor: AppColors.surface,
          style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
          isExpanded: true,
          hint: Text(label, style: TextStyle(color: AppColors.textSecondary)),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dots
          Row(
            children: List.generate(
              _pages.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _currentPage ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _currentPage
                      ? AppColors.primary
                      : AppColors.divider,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          // Button
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: Text(
              _currentPage == _pages.length - 1 ? 'ابدأ الآن' : 'التالي',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  final String icon;
  final String title;
  final String description;
  final Color color;
  final bool isSetup;

  _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isSetup = false,
  });
}

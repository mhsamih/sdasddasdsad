import 'package:flutter/material.dart';
import '../constants.dart';

class FortressTaskCard extends StatelessWidget {
  final int fortressIndex;
  final bool isCompleted;
  final ValueChanged<bool> onToggle;

  const FortressTaskCard({
    super.key,
    required this.fortressIndex,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final fortress = AppStrings.fortresses[fortressIndex];
    final color = AppColors.fortressColors[fortressIndex];

    return GestureDetector(
      onTap: () => onToggle(!isCompleted),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isCompleted
              ? color.withOpacity(0.15)
              : AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted ? color : AppColors.divider,
            width: isCompleted ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Fortress number circle
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? color : color.withOpacity(0.15),
                border: Border.all(
                  color: color.withOpacity(0.4),
                ),
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : Text(
                        fortress['number'] as String,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        fortress['subtitle'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        fortress['icon'] as String,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    fortress['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            // Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? color : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? color : AppColors.divider,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

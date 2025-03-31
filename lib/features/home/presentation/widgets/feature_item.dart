import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isVip;
  final VoidCallback onTap;

  const FeatureItem({
    super.key,
    required this.title,
    required this.icon,
    this.isVip = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.iconPrimary, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

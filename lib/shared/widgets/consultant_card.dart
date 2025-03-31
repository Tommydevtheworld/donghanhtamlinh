import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart' as app_colors;

class ConsultantCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final VoidCallback onTap;

  const ConsultantCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: app_colors.AppColors.secondary.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: app_colors.AppColors.secondary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: app_colors.AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 14,
                        color: app_colors.AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: app_colors.AppColors.primary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

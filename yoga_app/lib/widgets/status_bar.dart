import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.signal_cellular_alt, size: 16, color: AppColors.textPrimary),
              const SizedBox(width: 4),
              const Icon(Icons.wifi, size: 16, color: AppColors.textPrimary),
              const SizedBox(width: 4),
              const Icon(Icons.battery_full, size: 16, color: AppColors.textPrimary),
            ],
          ),
        ],
      ),
    );
  }
}

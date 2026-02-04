import 'package:flutter/material.dart';
import '../models/user.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';

class Header extends StatelessWidget {
  final User user;
  final VoidCallback? onNotificationTap;

  const Header({
    super.key,
    required this.user,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    user.profileImage,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '안녕하세요, ${user.name}님!',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onNotificationTap,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Image.network(
                AppImages.icNotification,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

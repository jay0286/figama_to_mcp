import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_images.dart';
import '../../core/theme/app_theme.dart';
import '../models/user.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.user,
    this.onNotificationTap,
  });

  final User user;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    user.profileImage,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '안녕하세요, ${user.name}님!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: colors.textPrimary,
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
              child: SvgPicture.asset(
                AppImages.icNotification,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

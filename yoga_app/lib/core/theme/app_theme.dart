import 'package:flutter/material.dart';

/// 앱의 시드 색상
const Color _seedColor = Color(0xFFFF9644);

/// 라이트 테마
final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  fontFamily: 'Pretendard',
);

/// 다크 테마
final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  fontFamily: 'Pretendard',
);

/// 앱 전용 색상 확장
/// Theme.of(context).extension<AppColorsExtension>()로 접근
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textDark,
    required this.popularBg,
    required this.popularText,
    required this.beginnerBg,
    required this.beginnerText,
    required this.therapyBg,
    required this.therapyText,
    required this.classCardPink,
    required this.classCardBlue,
    required this.classCardGreen,
  });

  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textDark;
  final Color popularBg;
  final Color popularText;
  final Color beginnerBg;
  final Color beginnerText;
  final Color therapyBg;
  final Color therapyText;
  final Color classCardPink;
  final Color classCardBlue;
  final Color classCardGreen;

  /// 라이트 모드 색상
  static const light = AppColorsExtension(
    background: Color(0xFFF2EEE8),
    textPrimary: Color(0xFF2A2A2A),
    textSecondary: Color(0xFF565656),
    textMuted: Color(0xFF939393),
    textDark: Color(0xFF562F00),
    popularBg: Color(0xFFFFF4EC),
    popularText: Color(0xFFFF9644),
    beginnerBg: Color(0xFFEFF6FF),
    beginnerText: Color(0xFF6795F7),
    therapyBg: Color(0xFFF0FDF4),
    therapyText: Color(0xFF009200),
    classCardPink: Color(0xFFF9F0F5),
    classCardBlue: Color(0xFFF0F4F8),
    classCardGreen: Color(0xFFF1F7F1),
  );

  /// 다크 모드 색상
  static const dark = AppColorsExtension(
    background: Color(0xFF1A1A1A),
    textPrimary: Color(0xFFE5E5E5),
    textSecondary: Color(0xFFB0B0B0),
    textMuted: Color(0xFF6C6C6C),
    textDark: Color(0xFFFFB366),
    popularBg: Color(0xFF3D2A1A),
    popularText: Color(0xFFFF9644),
    beginnerBg: Color(0xFF1A2A3D),
    beginnerText: Color(0xFF6795F7),
    therapyBg: Color(0xFF1A3D1A),
    therapyText: Color(0xFF00C200),
    classCardPink: Color(0xFF2D1F26),
    classCardBlue: Color(0xFF1F262D),
    classCardGreen: Color(0xFF1F2D1F),
  );

  @override
  AppColorsExtension copyWith({
    Color? background,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textDark,
    Color? popularBg,
    Color? popularText,
    Color? beginnerBg,
    Color? beginnerText,
    Color? therapyBg,
    Color? therapyText,
    Color? classCardPink,
    Color? classCardBlue,
    Color? classCardGreen,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textDark: textDark ?? this.textDark,
      popularBg: popularBg ?? this.popularBg,
      popularText: popularText ?? this.popularText,
      beginnerBg: beginnerBg ?? this.beginnerBg,
      beginnerText: beginnerText ?? this.beginnerText,
      therapyBg: therapyBg ?? this.therapyBg,
      therapyText: therapyText ?? this.therapyText,
      classCardPink: classCardPink ?? this.classCardPink,
      classCardBlue: classCardBlue ?? this.classCardBlue,
      classCardGreen: classCardGreen ?? this.classCardGreen,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textDark: Color.lerp(textDark, other.textDark, t)!,
      popularBg: Color.lerp(popularBg, other.popularBg, t)!,
      popularText: Color.lerp(popularText, other.popularText, t)!,
      beginnerBg: Color.lerp(beginnerBg, other.beginnerBg, t)!,
      beginnerText: Color.lerp(beginnerText, other.beginnerText, t)!,
      therapyBg: Color.lerp(therapyBg, other.therapyBg, t)!,
      therapyText: Color.lerp(therapyText, other.therapyText, t)!,
      classCardPink: Color.lerp(classCardPink, other.classCardPink, t)!,
      classCardBlue: Color.lerp(classCardBlue, other.classCardBlue, t)!,
      classCardGreen: Color.lerp(classCardGreen, other.classCardGreen, t)!,
    );
  }
}

/// 테마에 AppColorsExtension을 추가한 라이트 테마
final ThemeData appLightTheme = lightTheme.copyWith(
  extensions: [AppColorsExtension.light],
);

/// 테마에 AppColorsExtension을 추가한 다크 테마
final ThemeData appDarkTheme = darkTheme.copyWith(
  extensions: [AppColorsExtension.dark],
);

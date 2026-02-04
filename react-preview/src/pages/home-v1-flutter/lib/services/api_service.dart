import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/calendar_day.dart';
import '../models/booked_class.dart';
import '../models/popular_class.dart';
import '../models/health_stats.dart';
import '../models/recipe.dart';
import '../constants/app_images.dart';
import '../constants/app_colors.dart';

class ApiService {
  Future<User> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return User(
      id: 1,
      name: '수진',
      profileImage: AppImages.userProfile,
    );
  }

  Future<List<CalendarDay>> getCalendarDays() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [
      CalendarDay(dayName: '일', date: 15),
      CalendarDay(dayName: '월', date: 16),
      CalendarDay(dayName: '화', date: 17),
      CalendarDay(dayName: '수', date: 18, isSelected: true),
      CalendarDay(dayName: '목', date: 19),
      CalendarDay(dayName: '금', date: 20),
      CalendarDay(dayName: '토', date: 21),
    ];
  }

  Future<List<BookedClass>> getBookedClasses() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [
      BookedClass(
        id: 1,
        instructor: '이지연 강사',
        instructorImage: AppImages.instructor1,
        className: '빈야사 플로우',
        time: '07:30 - 08:30',
        rating: 4.8,
        bgColor: AppColors.classCardPink,
      ),
      BookedClass(
        id: 2,
        instructor: '박서윤 강사',
        instructorImage: AppImages.instructor2,
        className: '힐링 명상 요가',
        time: '09:30 - 10:00',
        rating: 4.8,
        bgColor: AppColors.classCardBlue,
      ),
      BookedClass(
        id: 3,
        instructor: '이지연 강사',
        instructorImage: AppImages.instructor1,
        className: '빈야사 플로우',
        time: '07:30 - 08:30',
        rating: 4.8,
        bgColor: AppColors.classCardGreen,
      ),
    ];
  }

  Future<HealthStats> getHealthStats() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return HealthStats(
      water: HealthStat(label: '수분', value: '1.2', unit: 'L'),
      steps: HealthStat(label: '걸음', value: '5,420', unit: ''),
      calories: HealthStat(label: '칼로리', value: '450', unit: 'kcal'),
    );
  }

  Future<List<PopularClass>> getPopularClasses() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [
      PopularClass(
        id: 1,
        name: '빈야사 플로우 다이어트',
        instructor: '박서윤 강사',
        time: '07:30 - 08:30',
        image: AppImages.classPhoto1,
        category: ClassCategory.popular,
        categoryLabel: '인기',
      ),
      PopularClass(
        id: 2,
        name: '빈야사 플로우 다이어트',
        instructor: '박서윤 강사',
        time: '07:30 - 08:30',
        image: AppImages.classPhoto2,
        category: ClassCategory.beginner,
        categoryLabel: '초급',
      ),
      PopularClass(
        id: 3,
        name: '빈야사 플로우 다이어트',
        instructor: '박서윤 강사',
        time: '07:30 - 08:30',
        image: AppImages.classPhoto3,
        category: ClassCategory.therapy,
        categoryLabel: '테라피',
      ),
    ];
  }

  Future<List<Recipe>> getRecentRecipes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [
      Recipe(
        id: 1,
        name: '빈야사 플로우 다이어트',
        description: '신선한 연어와 아보카도로 챙기는 고단백 영양 한 끼',
        image: AppImages.recipeFeatured,
        tag: 'Healthy & Fresh',
        cookTime: '15분',
        calories: '320kcal',
      ),
    ];
  }
}

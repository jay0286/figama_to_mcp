import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/calendar_day.dart';
import '../models/booked_class.dart';
import '../models/popular_class.dart';
import '../models/health_stats.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import '../constants/app_colors.dart';
import '../widgets/status_bar.dart';
import '../widgets/header.dart';
import '../widgets/calendar_section.dart';
import '../widgets/quick_stats/extended_stats_section.dart';
import '../widgets/popular_classes/popular_class_section.dart';
import '../widgets/recipe/recipe_section.dart';
import '../widgets/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();

  User? _user;
  List<CalendarDay> _calendarDays = [];
  List<BookedClass> _bookedClasses = [];
  List<PopularClass> _popularClasses = [];
  List<ExtendedHealthStat> _extendedStats = [];
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  String? _error;
  NavTab _activeTab = NavTab.home;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final results = await Future.wait([
        _apiService.getUserProfile(),
        _apiService.getCalendarDays(),
        _apiService.getBookedClasses(),
        _apiService.getPopularClasses(),
        _apiService.getExtendedHealthStats(),
        _apiService.getRecentRecipes(),
      ]);

      setState(() {
        _user = results[0] as User;
        _calendarDays = results[1] as List<CalendarDay>;
        _bookedClasses = results[2] as List<BookedClass>;
        _popularClasses = results[3] as List<PopularClass>;
        _extendedStats = results[4] as List<ExtendedHealthStat>;
        _recipes = results[5] as List<Recipe>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _selectDate(int date) {
    setState(() {
      _calendarDays = _calendarDays.map((day) {
        return day.copyWith(isSelected: day.date == date);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: AppColors.background,
        child: const Center(
          child: Text(
            '로딩 중...',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      return Container(
        color: AppColors.background,
        child: Center(
          child: Text(
            '오류: $_error',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main scrollable content
          Positioned.fill(
            bottom: 80,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const StatusBar(),
                  if (_user != null)
                    Header(
                      user: _user!,
                      onNotificationTap: () {
                        debugPrint('Notification tapped');
                      },
                    ),
                  CalendarSection(
                    calendarDays: _calendarDays,
                    bookedClasses: _bookedClasses,
                    onDateSelect: _selectDate,
                    onClassTap: (classData) {
                      debugPrint('Class tapped: ${classData.className}');
                    },
                  ),
                  ExtendedStatsSection(
                    stats: _extendedStats,
                    onStatTap: (stat) {
                      debugPrint('Stat tapped: ${stat.label}');
                    },
                  ),
                  const SizedBox(height: 12),
                  PopularClassSection(
                    classes: _popularClasses,
                    onClassTap: (classData) {
                      debugPrint('Popular class tapped: ${classData.name}');
                    },
                    onViewAllTap: () {
                      debugPrint('View all classes');
                    },
                  ),
                  RecipeSection(
                    recipes: _recipes,
                    onRecipeTap: (recipe) {
                      debugPrint('Recipe tapped: ${recipe.name}');
                    },
                    onViewAllTap: () {
                      debugPrint('View all recipes');
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Bottom navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNav(
              activeTab: _activeTab,
              onTabChange: (tab) {
                setState(() {
                  _activeTab = tab;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/bottom_navigation.dart';
import '../../../classes/presentation/widgets/popular_class_section.dart';
import '../../../recipe/presentation/widgets/recipe_section.dart';
import '../../../stats/presentation/widgets/extended_stats_section.dart';
import '../../data/home_repository.dart';
import '../widgets/calendar_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeRepository _repository = const HomeRepository();

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
        _repository.getUserProfile(),
        _repository.getCalendarDays(),
        _repository.getBookedClasses(),
        _repository.getPopularClasses(),
        _repository.getExtendedHealthStats(),
        _repository.getRecentRecipes(),
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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    if (_isLoading) {
      return Container(
        color: colors.background,
        child: Center(
          child: Text(
            '로딩 중...',
            style: TextStyle(
              color: colors.textMuted,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      return Container(
        color: colors.background,
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
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 80,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  if (_user != null)
                    AppHeader(
                      user: _user!,
                      onNotificationTap: () {
                        if (kDebugMode) {
                          print('Notification tapped');
                        }
                      },
                    ),
                  CalendarSection(
                    calendarDays: _calendarDays,
                    bookedClasses: _bookedClasses,
                    onDateSelect: _selectDate,
                    onClassTap: (classData) {
                      if (kDebugMode) {
                        print('Class tapped: ${classData.className}');
                      }
                    },
                  ),
                  ExtendedStatsSection(
                    stats: _extendedStats,
                    onStatTap: (stat) {
                      if (kDebugMode) {
                        print('Stat tapped: ${stat.label}');
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  PopularClassSection(
                    classes: _popularClasses,
                    onClassTap: (classData) {
                      if (kDebugMode) {
                        print('Popular class tapped: ${classData.name}');
                      }
                    },
                    onViewAllTap: () {
                      if (kDebugMode) {
                        print('View all classes');
                      }
                    },
                  ),
                  RecipeSection(
                    recipes: _recipes,
                    onRecipeTap: (recipe) {
                      if (kDebugMode) {
                        print('Recipe tapped: ${recipe.name}');
                      }
                    },
                    onViewAllTap: () {
                      if (kDebugMode) {
                        print('View all recipes');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavigation(
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

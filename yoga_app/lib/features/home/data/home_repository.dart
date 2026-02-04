import '../../../shared/models/models.dart';
import 'mock/home_mock_data.dart';

/// 홈 화면 데이터를 제공하는 레포지토리
/// 실제 앱에서는 API 호출로 대체됩니다.
class HomeRepository {
  const HomeRepository();

  Future<User> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return HomeMockData.user;
  }

  Future<List<CalendarDay>> getCalendarDays() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(HomeMockData.calendarDays);
  }

  Future<List<BookedClass>> getBookedClasses() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(HomeMockData.bookedClasses);
  }

  Future<List<ExtendedHealthStat>> getExtendedHealthStats() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(HomeMockData.extendedHealthStats);
  }

  Future<List<PopularClass>> getPopularClasses() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(HomeMockData.popularClasses);
  }

  Future<List<Recipe>> getRecentRecipes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(HomeMockData.recipes);
  }
}

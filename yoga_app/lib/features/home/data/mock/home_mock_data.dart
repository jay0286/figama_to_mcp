import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/models.dart';

/// 홈 화면 목데이터
/// 실제 API 연동 시 이 파일은 제거하거나 테스트용으로만 사용합니다.
class HomeMockData {
  const HomeMockData._();

  static const user = User(
    id: 1,
    name: '수진',
    profileImage: AppImages.userProfile,
  );

  static const calendarDays = [
    CalendarDay(dayName: '일', date: 15),
    CalendarDay(dayName: '월', date: 16),
    CalendarDay(dayName: '화', date: 17),
    CalendarDay(dayName: '수', date: 18, isSelected: true),
    CalendarDay(dayName: '목', date: 19),
    CalendarDay(dayName: '금', date: 20),
    CalendarDay(dayName: '토', date: 21),
  ];

  static final bookedClasses = [
    BookedClass(
      id: 1,
      instructor: '이지연 강사',
      instructorImage: AppImages.instructor1,
      className: '빈야사 플로우',
      time: '07:30 - 08:30',
      rating: 4.8,
      bgColor: AppColorsExtension.light.classCardPink,
    ),
    BookedClass(
      id: 2,
      instructor: '박서윤 강사',
      instructorImage: AppImages.instructor2,
      className: '힐링 명상 요가',
      time: '09:30 - 10:00',
      rating: 4.8,
      bgColor: AppColorsExtension.light.classCardBlue,
    ),
    BookedClass(
      id: 3,
      instructor: '김하늘 강사',
      instructorImage: AppImages.instructor1,
      className: '파워 요가',
      time: '11:00 - 12:00',
      rating: 4.9,
      bgColor: AppColorsExtension.light.classCardGreen,
    ),
    BookedClass(
      id: 4,
      instructor: '정민지 강사',
      instructorImage: AppImages.instructor2,
      className: '아침 스트레칭',
      time: '06:00 - 06:30',
      rating: 4.7,
      bgColor: AppColorsExtension.light.classCardPink,
    ),
    BookedClass(
      id: 5,
      instructor: '최유나 강사',
      instructorImage: AppImages.instructor1,
      className: '코어 강화 요가',
      time: '14:00 - 15:00',
      rating: 4.9,
      bgColor: AppColorsExtension.light.classCardBlue,
    ),
    BookedClass(
      id: 6,
      instructor: '이수민 강사',
      instructorImage: AppImages.instructor2,
      className: '저녁 릴렉스 요가',
      time: '19:00 - 20:00',
      rating: 4.6,
      bgColor: AppColorsExtension.light.classCardGreen,
    ),
    BookedClass(
      id: 7,
      instructor: '박지현 강사',
      instructorImage: AppImages.instructor1,
      className: '하타 요가',
      time: '08:00 - 09:00',
      rating: 4.8,
      bgColor: AppColorsExtension.light.classCardPink,
    ),
  ];

  static const extendedHealthStats = [
    ExtendedHealthStat(
      id: 1,
      label: '수분',
      value: '1.2',
      unit: 'L',
      type: 'water',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 2,
      label: '걸음',
      value: '5,420',
      unit: '걸음',
      type: 'steps',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 3,
      label: '칼로리',
      value: '450',
      unit: 'kcal',
      type: 'calories',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 4,
      label: '체중',
      value: '58.5',
      unit: 'kg',
      type: 'weight',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 5,
      label: '수면',
      value: '7.5',
      unit: '시간',
      type: 'sleep',
      date: '어제',
    ),
    ExtendedHealthStat(
      id: 6,
      label: '심박수',
      value: '72',
      unit: 'bpm',
      type: 'heart',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 7,
      label: '체지방',
      value: '22.3',
      unit: '%',
      type: 'fat',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 8,
      label: '근육량',
      value: '24.2',
      unit: 'kg',
      type: 'muscle',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 9,
      label: '스트레스',
      value: '낮음',
      unit: '',
      type: 'stress',
      date: '오늘',
    ),
    ExtendedHealthStat(
      id: 10,
      label: '명상 시간',
      value: '15',
      unit: '분',
      type: 'meditation',
      date: '오늘',
    ),
  ];

  static const popularClasses = [
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
      name: '초보자 하타 요가',
      instructor: '이지연 강사',
      time: '09:00 - 10:00',
      image: AppImages.classPhoto2,
      category: ClassCategory.beginner,
      categoryLabel: '초급',
    ),
    PopularClass(
      id: 3,
      name: '스트레스 해소 테라피',
      instructor: '김하늘 강사',
      time: '11:00 - 12:00',
      image: AppImages.classPhoto3,
      category: ClassCategory.therapy,
      categoryLabel: '테라피',
    ),
    PopularClass(
      id: 4,
      name: '파워 요가 챌린지',
      instructor: '정민지 강사',
      time: '14:00 - 15:00',
      image: AppImages.classPhoto1,
      category: ClassCategory.popular,
      categoryLabel: '인기',
    ),
    PopularClass(
      id: 5,
      name: '유연성 향상 요가',
      instructor: '최유나 강사',
      time: '16:00 - 17:00',
      image: AppImages.classPhoto2,
      category: ClassCategory.beginner,
      categoryLabel: '초급',
    ),
    PopularClass(
      id: 6,
      name: '수면 개선 요가',
      instructor: '이수민 강사',
      time: '21:00 - 21:30',
      image: AppImages.classPhoto3,
      category: ClassCategory.therapy,
      categoryLabel: '테라피',
    ),
    PopularClass(
      id: 7,
      name: '코어 강화 필라테스',
      instructor: '박지현 강사',
      time: '10:00 - 11:00',
      image: AppImages.classPhoto1,
      category: ClassCategory.popular,
      categoryLabel: '인기',
    ),
    PopularClass(
      id: 8,
      name: '명상과 호흡법',
      instructor: '김소연 강사',
      time: '06:30 - 07:00',
      image: AppImages.classPhoto2,
      category: ClassCategory.therapy,
      categoryLabel: '테라피',
    ),
    PopularClass(
      id: 9,
      name: '전신 스트레칭',
      instructor: '이하나 강사',
      time: '08:00 - 08:30',
      image: AppImages.classPhoto3,
      category: ClassCategory.beginner,
      categoryLabel: '초급',
    ),
    PopularClass(
      id: 10,
      name: '다이어트 요가',
      instructor: '최민정 강사',
      time: '18:00 - 19:00',
      image: AppImages.classPhoto1,
      category: ClassCategory.popular,
      categoryLabel: '인기',
    ),
  ];

  static const recipes = [
    Recipe(
      id: 1,
      name: '연어 아보카도 샐러드',
      description: '신선한 연어와 아보카도로 챙기는 고단백 영양 한 끼',
      image: AppImages.recipeFeatured,
      tag: 'Healthy & Fresh',
      cookTime: '15분',
      calories: '320kcal',
    ),
  ];
}

import { images } from '../constants/images';

// Mock data based on flutter_aandi_renamed.jsx
const mockUser = {
  id: 1,
  name: '수진',
  profileImage: images.profile.user,
};

const mockCalendarDays = [
  { dayName: '일', date: 15, isSelected: false },
  { dayName: '월', date: 16, isSelected: false },
  { dayName: '화', date: 17, isSelected: false },
  { dayName: '수', date: 18, isSelected: true },
  { dayName: '목', date: 19, isSelected: false },
  { dayName: '금', date: 20, isSelected: false },
  { dayName: '토', date: 21, isSelected: false },
];

const mockBookedClasses = [
  {
    id: 1,
    instructor: '이지연 강사',
    instructorImage: images.profile.instructor1,
    className: '빈야사 플로우',
    time: '07:30 - 08:30',
    rating: 4.8,
    bgColor: '#f9f0f5',
  },
  {
    id: 2,
    instructor: '박서윤 강사',
    instructorImage: images.profile.instructor2,
    className: '힐링 명상 요가',
    time: '09:30 - 10:00',
    rating: 4.8,
    bgColor: '#f0f4f8',
  },
  {
    id: 3,
    instructor: '이지연 강사',
    instructorImage: images.profile.instructor1,
    className: '빈야사 플로우',
    time: '07:30 - 08:30',
    rating: 4.8,
    bgColor: '#f1f7f1',
  },
];

const mockHealthStats = {
  water: { label: '수분', value: '1.2', unit: 'L' },
  steps: { label: '걸음', value: '5,420', unit: '' },
  calories: { label: '칼로리', value: '450', unit: 'kcal' },
};

const mockPopularClasses = [
  {
    id: 1,
    name: '빈야사 플로우 다이어트',
    instructor: '박서윤 강사',
    time: '07:30 - 08:30',
    image: images.classes.photo1,
    category: 'popular',
    categoryLabel: '인기',
  },
  {
    id: 2,
    name: '빈야사 플로우 다이어트',
    instructor: '박서윤 강사',
    time: '07:30 - 08:30',
    image: images.classes.photo2,
    category: 'beginner',
    categoryLabel: '초급',
  },
  {
    id: 3,
    name: '빈야사 플로우 다이어트',
    instructor: '박서윤 강사',
    time: '07:30 - 08:30',
    image: images.classes.photo3,
    category: 'therapy',
    categoryLabel: '테라피',
  },
];

const mockRecipes = [
  {
    id: 1,
    name: '빈야사 플로우 다이어트',
    description: '신선한 연어와 아보카도로 챙기는 고단백 영양 한 끼',
    image: images.recipe.featured,
    tag: 'Healthy & Fresh',
    cookTime: '15분',
    calories: '320kcal',
  },
];

// Simulated API delay
const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

export const api = {
  async getUserProfile() {
    await delay(100);
    return mockUser;
  },

  async getCalendarDays() {
    await delay(100);
    return mockCalendarDays;
  },

  async getBookedClasses() {
    await delay(100);
    return mockBookedClasses;
  },

  async getHealthStats() {
    await delay(100);
    return mockHealthStats;
  },

  async getPopularClasses() {
    await delay(100);
    return mockPopularClasses;
  },

  async getRecentRecipes() {
    await delay(100);
    return mockRecipes;
  },
};

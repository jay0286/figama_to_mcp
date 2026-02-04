// Mock API service
import { images } from '../constants/images';

// Simulated API delay
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

export const api = {
  // Fetch user profile
  async getUserProfile() {
    await delay(300);
    return {
      id: 1,
      name: '수진',
      avatar: images.profile.user,
    };
  },

  // Fetch booked classes
  async getBookedClasses() {
    await delay(300);
    return [
      {
        id: 1,
        instructor: '이지연',
        instructorImage: images.profile.instructor1,
        className: '빈야사 플로우',
        time: '07:30 - 08:30',
        rating: 4.8,
        bgColor: '#f9f0f5',
      },
      {
        id: 2,
        instructor: '박서윤',
        instructorImage: images.profile.instructor2,
        className: '힐링 명상 요가',
        time: '09:30 - 10:00',
        rating: 4.8,
        bgColor: '#f0f4f8',
      },
      {
        id: 3,
        instructor: '이지연',
        instructorImage: images.profile.instructor1,
        className: '빈야사 플로우',
        time: '07:30 - 08:30',
        rating: 4.8,
        bgColor: '#f1f7f1',
      },
    ];
  },

  // Fetch popular classes
  async getPopularClasses() {
    await delay(300);
    return [
      {
        id: 1,
        title: '빈야사 플로우 다이어트',
        instructor: '박서윤',
        time: '07:30 - 08:30',
        category: 'popular',
        categoryLabel: '인기',
        image: images.classes.photo1,
      },
      {
        id: 2,
        title: '빈야사 플로우 다이어트',
        instructor: '박서윤',
        time: '07:30 - 08:30',
        category: 'beginner',
        categoryLabel: '초급',
        image: images.classes.photo2,
      },
      {
        id: 3,
        title: '빈야사 플로우 다이어트',
        instructor: '박서윤',
        time: '07:30 - 08:30',
        category: 'therapy',
        categoryLabel: '테라피',
        image: images.classes.photo3,
      },
    ];
  },

  // Fetch health stats
  async getHealthStats() {
    await delay(200);
    return {
      water: { value: 1.2, unit: 'L' },
      steps: { value: 5420, unit: '' },
      calories: { value: 450, unit: 'kcal' },
    };
  },

  // Fetch recent recipes
  async getRecentRecipes() {
    await delay(300);
    return [
      {
        id: 1,
        title: '빈야사 플로우 다이어트',
        description: '신선한 연어와 아보카도로 챙기는 고단백 영양 한 끼',
        image: images.recipe.featured,
        cookTime: '15분',
        calories: '320kcal',
        tag: 'Healthy & Fresh',
      },
    ];
  },
};

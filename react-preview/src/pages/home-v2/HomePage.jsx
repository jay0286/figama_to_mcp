import { useState } from 'react';
import { useHomeData } from './hooks/useHomeData';
import {
  StatusBar,
  Header,
  CalendarSection,
  QuickStatsRow,
  PopularClassSection,
  RecipeSection,
  BottomNav,
} from './components';

export function HomePage() {
  const {
    user,
    calendarDays,
    bookedClasses,
    popularClasses,
    healthStats,
    recipes,
    loading,
    error,
    selectDate,
  } = useHomeData();

  const [activeTab, setActiveTab] = useState('home');

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full bg-[#f2eee8]">
        <p className="text-[#939393]">로딩 중...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-full bg-[#f2eee8]">
        <p className="text-red-500">오류: {error}</p>
      </div>
    );
  }

  const handleNotificationClick = () => {
    console.log('Notification clicked');
  };

  const handleClassClick = (classData) => {
    console.log('Class clicked:', classData);
  };

  const handleStatClick = (statType) => {
    console.log('Stat clicked:', statType);
  };

  const handlePopularClassClick = (classData) => {
    console.log('Popular class clicked:', classData);
  };

  const handleRecipeClick = (recipe) => {
    console.log('Recipe clicked:', recipe);
  };

  const handleViewAllClasses = () => {
    console.log('View all classes');
  };

  const handleViewAllRecipes = () => {
    console.log('View all recipes');
  };

  return (
    <div className="bg-[#f2eee8] relative size-full">
      <div className="absolute content-stretch flex flex-col items-start left-0 top-0 w-[390px] pb-[80px]">
        <StatusBar />
        <Header user={user} onNotificationClick={handleNotificationClick} />
        <CalendarSection
          calendarDays={calendarDays}
          bookedClasses={bookedClasses}
          onDateSelect={selectDate}
          onClassClick={handleClassClick}
        />
        <QuickStatsRow stats={healthStats} onStatClick={handleStatClick} />
        <PopularClassSection
          classes={popularClasses}
          onClassClick={handlePopularClassClick}
          onViewAll={handleViewAllClasses}
        />
        <RecipeSection
          recipes={recipes}
          onRecipeClick={handleRecipeClick}
          onViewAll={handleViewAllRecipes}
        />
      </div>
      <BottomNav activeTab={activeTab} onTabChange={setActiveTab} />
    </div>
  );
}

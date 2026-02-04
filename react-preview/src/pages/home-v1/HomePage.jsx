import { useState } from 'react';
import { useHomeData } from './hooks/useHomeData';
import { images } from './constants/images';
import {
  Header,
  WeekView,
  StatCard,
  BookedClassCard,
  PopularClassCard,
  RecipeCard,
  BottomNav,
} from './components';

export function HomePage() {
  const { user, bookedClasses, popularClasses, healthStats, recipes, loading, error } = useHomeData();
  const [activeTab, setActiveTab] = useState('home');
  const [selectedDate, setSelectedDate] = useState(new Date());

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full bg-[#faf8f6]">
        <p className="text-[#939393]">로딩 중...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-full bg-[#faf8f6]">
        <p className="text-red-500">오류: {error}</p>
      </div>
    );
  }

  return (
    <div className="bg-[#faf8f6] flex flex-col h-[844px] items-center overflow-clip relative w-[390px]">
      {/* Status Bar */}
      <div className="content-stretch flex h-[47px] items-center justify-between px-[20px] relative shrink-0 w-full z-20">
        <div className="flex flex-col items-start justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[17px]">
          <img alt="Time" className="h-[21px] w-[54px]" src={images.statusBar.time} />
        </div>
        <div className="content-stretch flex gap-[4px] items-center justify-end relative shrink-0">
          <div className="overflow-clip relative shrink-0 size-[18px]">
            <img alt="Signal" className="block max-w-none size-full" src={images.statusBar.signal} />
          </div>
          <div className="overflow-clip relative shrink-0 size-[18px]">
            <img alt="WiFi" className="block max-w-none size-full" src={images.statusBar.wifi} />
          </div>
          <img alt="Battery" className="h-[13px] relative shrink-0 w-[27px]" src={images.statusBar.battery} />
        </div>
      </div>

      {/* Scrollable Content */}
      <div className="content-stretch flex flex-col gap-[24px] items-center overflow-y-auto pb-[100px] pt-[8px] px-[20px] relative w-full flex-1">
        {/* Header */}
        <Header user={user} onNotificationClick={() => console.log('Notification clicked')} />

        {/* Calendar Section */}
        <div className="content-stretch flex flex-col gap-[16px] items-start relative shrink-0 w-full">
          <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[18px] w-full">
            <p className="leading-[26px] whitespace-pre-wrap">클래스 일정</p>
          </div>
          <WeekView selectedDate={selectedDate} onDateSelect={setSelectedDate} />
        </div>

        {/* Booked Classes Section */}
        {bookedClasses.length > 0 && (
          <div className="content-stretch flex gap-[12px] items-start relative shrink-0 w-full">
            {bookedClasses.map((classData) => (
              <BookedClassCard
                key={classData.id}
                classData={classData}
                onClick={() => console.log('Class clicked:', classData.id)}
              />
            ))}
          </div>
        )}

        {/* Health Stats Section */}
        {healthStats && (
          <div className="content-stretch flex gap-[12px] items-start relative shrink-0 w-full">
            <StatCard
              icon={images.icons.water}
              label={healthStats.water.label}
              value={healthStats.water.value}
              unit={healthStats.water.unit}
              onClick={() => console.log('Water clicked')}
            />
            <StatCard
              icon={images.icons.steps}
              label={healthStats.steps.label}
              value={healthStats.steps.value}
              unit={healthStats.steps.unit}
              onClick={() => console.log('Steps clicked')}
            />
            <StatCard
              icon={images.icons.calories}
              label={healthStats.calories.label}
              value={healthStats.calories.value}
              unit={healthStats.calories.unit}
              onClick={() => console.log('Calories clicked')}
            />
          </div>
        )}

        {/* Popular Classes Section */}
        <div className="content-stretch flex flex-col gap-[16px] items-start relative shrink-0 w-full">
          <div className="content-stretch flex items-center justify-between relative shrink-0 w-full">
            <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[18px]">
              <p className="leading-[26px] whitespace-pre-wrap">인기 클래스</p>
            </div>
            <button className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#939393] text-[14px] cursor-pointer">
              <p className="leading-[20px] whitespace-pre-wrap">전체보기</p>
            </button>
          </div>
          <div className="content-stretch flex flex-col gap-[12px] items-start relative shrink-0 w-full">
            {popularClasses.map((classData) => (
              <PopularClassCard
                key={classData.id}
                classData={classData}
                onClick={() => console.log('Popular class clicked:', classData.id)}
              />
            ))}
          </div>
        </div>

        {/* Recipe Section */}
        <div className="content-stretch flex flex-col gap-[16px] items-start relative shrink-0 w-full">
          <div className="content-stretch flex items-center justify-between relative shrink-0 w-full">
            <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[18px]">
              <p className="leading-[26px] whitespace-pre-wrap">최근 본 레시피</p>
            </div>
            <button className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#939393] text-[14px] cursor-pointer">
              <p className="leading-[20px] whitespace-pre-wrap">전체보기</p>
            </button>
          </div>
          {recipes.map((recipe) => (
            <RecipeCard
              key={recipe.id}
              recipe={recipe}
              onClick={() => console.log('Recipe clicked:', recipe.id)}
            />
          ))}
        </div>
      </div>

      {/* Bottom Navigation */}
      <BottomNav activeTab={activeTab} onTabChange={setActiveTab} />
    </div>
  );
}

import { images } from '../constants/images';

const NAV_ITEMS = [
  { id: 'home', label: '홈', icon: images.icons.home },
  { id: 'classes', label: '클래스', icon: images.icons.calendar },
  { id: 'diet', label: '식단', icon: images.icons.diet },
  { id: 'profile', label: '내정보', icon: images.icons.user },
];

export function BottomNav({ activeTab = 'home', onTabChange }) {
  return (
    <div className="absolute bg-white bottom-0 content-stretch flex gap-[4px] items-center left-0 pb-[24px] px-[20px] w-[390px]">
      {NAV_ITEMS.map((item) => (
        <button
          key={item.id}
          onClick={() => onTabChange?.(item.id)}
          className="content-stretch flex flex-[1_0_0] flex-col gap-[4px] h-[56px] items-center justify-center min-h-px min-w-px relative cursor-pointer"
        >
          <div className="overflow-clip relative shrink-0 size-[24px]">
            <img alt={item.label} className="block max-w-none size-full" src={item.icon} />
          </div>
          <div
            className={`flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[12px] text-center whitespace-nowrap transition-colors ${
              activeTab === item.id ? 'text-[#ff9644]' : 'text-[#939393]'
            }`}
          >
            <p className="leading-[16px]">{item.label}</p>
          </div>
        </button>
      ))}
    </div>
  );
}

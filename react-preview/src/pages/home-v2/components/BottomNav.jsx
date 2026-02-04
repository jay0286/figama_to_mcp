import { images } from '../constants/images';
import { colors } from '../constants/colors';

const navItems = [
  { id: 'home', label: '홈', icon: images.icons.home },
  { id: 'classes', label: '클래스', icon: images.icons.calendar },
  { id: 'diets', label: '식단', icon: images.icons.diet },
  { id: 'profile', label: '내정보', icon: images.icons.user },
];

export function BottomNav({ activeTab, onTabChange }) {
  return (
    <div className="absolute bg-white bottom-0 content-stretch flex gap-[4px] items-center left-0 pb-[24px] px-[20px] w-[390px]">
      {navItems.map((item) => {
        const isActive = activeTab === item.id;
        const textColor = isActive ? colors.primary : colors.text.muted;

        return (
          <button
            key={item.id}
            onClick={() => onTabChange(item.id)}
            className="content-stretch flex flex-[1_0_0] flex-col gap-[4px] h-[56px] items-center justify-center min-h-px min-w-px relative cursor-pointer"
          >
            <div className="overflow-clip relative shrink-0 size-[24px]">
              <img
                alt={item.label}
                className="block max-w-none size-full"
                src={item.icon}
                style={{ filter: isActive ? 'none' : 'grayscale(100%) opacity(0.5)' }}
              />
            </div>
            <div
              className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[12px] text-center whitespace-nowrap"
              style={{ color: textColor }}
            >
              <p className="leading-[16px]">{item.label}</p>
            </div>
          </button>
        );
      })}
    </div>
  );
}

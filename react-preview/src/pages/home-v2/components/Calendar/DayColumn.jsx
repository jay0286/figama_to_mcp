import { colors } from '../../constants/colors';

export function DayColumn({ dayName, date, isSelected, onClick }) {
  const dayColor = isSelected ? colors.primary : colors.text.muted;
  const dateContainerStyle = isSelected
    ? 'bg-[#ff9644] shadow-[0px_4px_8px_0px_rgba(255,150,68,0.25)]'
    : '';
  const dateTextColor = isSelected ? 'text-white' : 'text-[#2a2a2a]';

  return (
    <div
      className="content-stretch flex flex-col gap-[8px] items-center relative shrink-0 w-[40px] cursor-pointer"
      onClick={() => onClick(date)}
    >
      <div
        className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[12px] text-center w-full"
        style={{ color: dayColor }}
      >
        <p className="leading-[16px] whitespace-pre-wrap">{dayName}</p>
      </div>
      <div
        className={`content-stretch flex flex-col h-[40px] items-center justify-center p-[10px] relative rounded-[9999px] shrink-0 w-full ${dateContainerStyle}`}
      >
        <div
          className={`flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[14px] text-center whitespace-nowrap ${dateTextColor}`}
        >
          <p className="leading-[20px]">{date}</p>
        </div>
      </div>
    </div>
  );
}

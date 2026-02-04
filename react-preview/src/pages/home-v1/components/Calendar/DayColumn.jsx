export function DayColumn({ dayName, date, isSelected, onClick }) {
  return (
    <button
      onClick={onClick}
      className="content-stretch flex flex-col gap-[8px] items-center relative shrink-0 w-[40px] cursor-pointer"
    >
      <div
        className={`flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[12px] text-center w-full ${
          isSelected ? 'text-[#ff9644]' : 'text-[#939393]'
        }`}
      >
        <p className="leading-[16px] whitespace-pre-wrap">{dayName}</p>
      </div>
      <div
        className={`content-stretch flex flex-col h-[40px] items-center justify-center p-[10px] relative rounded-[9999px] shrink-0 w-full transition-all ${
          isSelected
            ? 'bg-[#ff9644] shadow-[0px_4px_8px_0px_rgba(255,150,68,0.25)]'
            : 'hover:bg-gray-100'
        }`}
      >
        <div
          className={`flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[14px] text-center whitespace-nowrap ${
            isSelected ? 'text-white' : 'text-[#2a2a2a]'
          }`}
        >
          <p className="leading-[20px]">{date}</p>
        </div>
      </div>
    </button>
  );
}

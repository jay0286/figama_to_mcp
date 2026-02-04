import { WeekCalendar } from './Calendar';
import { BookedClassList } from './BookedClasses';

export function CalendarSection({ calendarDays, bookedClasses, onDateSelect, onClassClick }) {
  return (
    <div className="content-stretch flex flex-col items-start pb-[12px] pt-[16px] px-[20px] relative shrink-0 w-full">
      <div className="bg-white content-stretch flex flex-col gap-[16px] items-start p-[16px] relative rounded-[16px] shrink-0 w-full">
        <WeekCalendar days={calendarDays} onDateSelect={onDateSelect} />
        <div className="content-stretch flex flex-col gap-[8px] items-start relative shrink-0 w-full">
          <div className="content-stretch flex gap-[20px] items-center leading-[0] not-italic py-[4px] relative shrink-0 w-full">
            <div className="flex flex-[1_0_0] flex-col font-['Pretendard:SemiBold',sans-serif] justify-center min-h-px min-w-px relative text-[#2a2a2a] text-[14px]">
              <p className="leading-[20px] whitespace-pre-wrap">예약된 클래스</p>
            </div>
            <button className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center relative shrink-0 text-[#939393] text-[12px] text-center whitespace-nowrap cursor-pointer">
              <p className="leading-[16px]">전체보기</p>
            </button>
          </div>
          <BookedClassList classes={bookedClasses} onClassClick={onClassClick} />
        </div>
      </div>
    </div>
  );
}

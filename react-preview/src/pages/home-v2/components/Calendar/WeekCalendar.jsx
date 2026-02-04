import { DayColumn } from './DayColumn';

export function WeekCalendar({ days, onDateSelect }) {
  return (
    <div className="content-stretch flex items-center justify-between relative shrink-0 w-full">
      {days.map((day) => (
        <DayColumn
          key={day.date}
          dayName={day.dayName}
          date={day.date}
          isSelected={day.isSelected}
          onClick={onDateSelect}
        />
      ))}
    </div>
  );
}

import { useState } from 'react';
import { DayColumn } from './DayColumn';

const DAYS = ['일', '월', '화', '수', '목', '금', '토'];
const DATES = [15, 16, 17, 18, 19, 20, 21];

export function WeekView({ onDateSelect }) {
  const [selectedDate, setSelectedDate] = useState(18);

  const handleDateClick = (date) => {
    setSelectedDate(date);
    onDateSelect?.(date);
  };

  return (
    <div className="content-stretch flex items-center justify-between relative shrink-0 w-full">
      {DAYS.map((day, index) => (
        <DayColumn
          key={day}
          dayName={day}
          date={DATES[index]}
          isSelected={DATES[index] === selectedDate}
          onClick={() => handleDateClick(DATES[index])}
        />
      ))}
    </div>
  );
}

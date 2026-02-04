import { BookedClassCard } from './BookedClassCard';

export function BookedClassList({ classes, onClassClick }) {
  return (
    <div className="h-[132px] overflow-clip relative shrink-0 w-full">
      <div className="absolute content-stretch flex gap-[8px] items-start left-0 top-0 w-[447px]">
        {classes.map((classData) => (
          <BookedClassCard
            key={classData.id}
            classData={classData}
            onClick={() => onClassClick(classData)}
          />
        ))}
      </div>
    </div>
  );
}

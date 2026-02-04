import { images } from '../../constants/images';

export function BookedClassCard({ classData, onClick }) {
  const { instructor, instructorImage, className, time, rating, bgColor } = classData;

  return (
    <div
      className="content-stretch flex flex-[1_0_0] flex-col gap-[4px] items-start justify-center min-h-px min-w-px p-[16px] relative rounded-[12px] cursor-pointer"
      style={{ backgroundColor: bgColor }}
      onClick={onClick}
    >
      <div className="content-stretch flex items-center justify-between relative shrink-0 w-full">
        <div className="border border-solid border-white relative rounded-[9999px] shrink-0 size-[32px] overflow-hidden">
          <img
            alt={instructor}
            className="absolute inset-0 max-w-none object-cover pointer-events-none size-full"
            src={instructorImage}
          />
        </div>
        <div className="bg-white content-stretch flex h-[20px] items-center justify-center px-[6px] py-[10px] relative rounded-[999px] shrink-0">
          <div className="content-stretch flex gap-[4px] items-center justify-center relative shrink-0">
            <div className="overflow-clip relative shrink-0 size-[12px]">
              <img alt="별점" className="block max-w-none size-full" src={images.icons.rate} />
            </div>
            <div className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#565656] text-[10px] text-center tracking-[0.4px] whitespace-nowrap">
              <p className="leading-[14px]">{rating}</p>
            </div>
          </div>
        </div>
      </div>
      <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[14px] w-full">
        <p className="leading-[20px] whitespace-pre-wrap">{instructor}</p>
      </div>
      <div className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#565656] text-[14px] w-full">
        <p className="leading-[20px] whitespace-pre-wrap">{className}</p>
      </div>
      <div className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#939393] text-[12px] w-full">
        <p className="leading-[16px] whitespace-pre-wrap">{time}</p>
      </div>
    </div>
  );
}

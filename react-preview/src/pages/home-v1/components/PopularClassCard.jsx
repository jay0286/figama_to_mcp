import { images } from '../constants/images';
import { colors } from '../constants/colors';

export function PopularClassCard({ classData, onClick }) {
  const { title, instructor, time, category, categoryLabel, image } = classData;

  const categoryStyle = colors.category[category] || colors.category.popular;

  return (
    <button
      onClick={onClick}
      className="bg-white content-stretch flex gap-[12px] items-center p-[16px] relative rounded-[16px] shrink-0 w-full cursor-pointer hover:shadow-md transition-shadow text-left"
    >
      <div className="relative rounded-[12px] shrink-0 size-[96px]">
        <div className="absolute inset-0 pointer-events-none rounded-[12px]">
          <div className="absolute bg-white inset-0 rounded-[12px]" />
          <img
            alt={title}
            className="absolute max-w-none object-cover rounded-[12px] size-full"
            src={image}
          />
        </div>
      </div>
      <div className="content-stretch flex flex-[1_0_0] flex-col gap-[4px] items-start min-h-px min-w-px relative">
        <div
          className="content-stretch flex h-[20px] items-center justify-center px-[6px] py-[10px] relative rounded-[999px] shrink-0"
          style={{ backgroundColor: categoryStyle.bg }}
        >
          <div
            className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[10px] whitespace-nowrap"
            style={{ color: categoryStyle.text }}
          >
            <p className="leading-[14px]">{categoryLabel}</p>
          </div>
        </div>
        <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] min-w-full not-italic relative shrink-0 text-[#2a2a2a] text-[16px] w-[min-content]">
          <p className="leading-[24px] whitespace-pre-wrap">{title}</p>
        </div>
        <div className="content-stretch flex gap-[4px] items-center relative shrink-0 w-full">
          <div className="overflow-clip relative shrink-0 size-[16px]">
            <img alt="시간" className="block max-w-none size-full" src={images.icons.time} />
          </div>
          <div className="flex flex-col font-['Pretendard:Regular',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#565656] text-[14px] whitespace-nowrap">
            <p className="leading-[20px]">{time}</p>
          </div>
        </div>
        <div className="flex flex-col font-['Pretendard:Regular',sans-serif] justify-center leading-[0] min-w-full not-italic relative shrink-0 text-[#939393] text-[12px] w-[min-content]">
          <p className="leading-[16px] whitespace-pre-wrap">{instructor} 강사</p>
        </div>
      </div>
    </button>
  );
}

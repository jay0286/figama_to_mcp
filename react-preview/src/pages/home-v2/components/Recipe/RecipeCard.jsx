import { images } from '../../constants/images';

export function RecipeCard({ recipe, onClick }) {
  const { name, description, image, tag, cookTime, calories } = recipe;

  return (
    <div
      className="content-stretch flex flex-col items-start relative shrink-0 w-full cursor-pointer"
      onClick={onClick}
    >
      <div className="content-stretch flex flex-col h-[168px] items-end overflow-clip p-[16px] relative rounded-tl-[16px] rounded-tr-[16px] shrink-0 w-full">
        <div
          aria-hidden="true"
          className="absolute inset-0 pointer-events-none rounded-tl-[16px] rounded-tr-[16px]"
        >
          <div className="absolute bg-white inset-0 rounded-tl-[16px] rounded-tr-[16px]" />
          <img
            alt={name}
            className="absolute max-w-none object-cover rounded-tl-[16px] rounded-tr-[16px] size-full"
            src={image}
          />
        </div>
        <div className="bg-white content-stretch flex h-[20px] items-center justify-center px-[6px] py-[10px] relative rounded-[999px] shrink-0">
          <div className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#ff9644] text-[10px] whitespace-nowrap">
            <p className="leading-[14px]">{tag}</p>
          </div>
        </div>
      </div>
      <div className="bg-white content-stretch flex flex-col gap-[8px] items-start p-[16px] relative rounded-bl-[16px] rounded-br-[16px] shrink-0 w-full">
        <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[16px] w-full">
          <p className="leading-[24px] whitespace-pre-wrap">{name}</p>
        </div>
        <p className="font-['Pretendard:Regular',sans-serif] h-[40px] leading-[20px] not-italic relative shrink-0 text-[#565656] text-[14px] w-full whitespace-pre-wrap">
          {description}
        </p>
        <div className="content-stretch flex gap-[20px] items-center relative shrink-0 w-full">
          <div className="content-stretch flex gap-[4px] items-center relative shrink-0">
            <div className="overflow-clip relative shrink-0 size-[16px]">
              <img alt="조리시간" className="block max-w-none size-full" src={images.icons.timer} />
            </div>
            <div className="flex flex-col font-['Pretendard:Regular',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#939393] text-[12px] whitespace-nowrap">
              <p className="leading-[16px]">{cookTime}</p>
            </div>
          </div>
          <div className="content-stretch flex gap-[4px] items-center relative shrink-0">
            <div className="overflow-clip relative shrink-0 size-[16px]">
              <img alt="칼로리" className="block max-w-none size-full" src={images.icons.energy} />
            </div>
            <div className="flex flex-col font-['Pretendard:Regular',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#939393] text-[12px] whitespace-nowrap">
              <p className="leading-[16px]">{calories}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

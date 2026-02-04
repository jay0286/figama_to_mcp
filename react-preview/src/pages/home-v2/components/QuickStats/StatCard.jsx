import { images } from '../../constants/images';

const iconMap = {
  water: images.icons.water,
  steps: images.icons.steps,
  calories: images.icons.calories,
};

export function StatCard({ type, label, value, unit, onClick }) {
  const icon = iconMap[type];

  return (
    <div className="flex flex-[1_0_0] flex-row items-center self-stretch">
      <div
        className="bg-white content-stretch flex flex-[1_0_0] flex-col gap-[12px] h-full items-start justify-end min-h-px min-w-px p-[16px] relative rounded-[16px] cursor-pointer"
        onClick={onClick}
      >
        <div className="content-stretch flex gap-[4px] items-center relative shrink-0 w-full">
          <div className="overflow-clip relative shrink-0 size-[16px]">
            <img alt={label} className="block max-w-none size-full" src={icon} />
          </div>
          <div className="flex flex-[1_0_0] flex-col font-['Pretendard:Medium',sans-serif] justify-center leading-[0] min-h-px min-w-px not-italic relative text-[#ff9644] text-[12px]">
            <p className="leading-[16px] whitespace-pre-wrap">{label}</p>
          </div>
        </div>
        <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] h-[24px] justify-center leading-[0] not-italic relative shrink-0 text-[#562f00] w-full">
          {unit ? (
            <p className="whitespace-pre-wrap">
              <span className="leading-[20px] text-[16px]">{value}</span>
              <span className="leading-[16px] text-[12px]">{unit}</span>
            </p>
          ) : (
            <p className="leading-[20px] text-[16px] whitespace-pre-wrap">{value}</p>
          )}
        </div>
      </div>
    </div>
  );
}

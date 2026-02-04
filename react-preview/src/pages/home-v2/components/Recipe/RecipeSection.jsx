import { RecipeCard } from './RecipeCard';

export function RecipeSection({ recipes, onRecipeClick, onViewAll }) {
  return (
    <div className="content-stretch flex flex-col gap-[12px] items-start pb-[24px] pt-[6px] px-[20px] relative shrink-0 w-full">
      <div className="content-stretch flex items-center justify-between leading-[0] not-italic py-[4px] relative shrink-0 text-center w-full whitespace-nowrap">
        <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center relative shrink-0 text-[#2a2a2a] text-[18px]">
          <p className="leading-[24px]">최근 식단 레시피</p>
        </div>
        <button
          onClick={onViewAll}
          className="flex flex-col font-['Pretendard:Medium',sans-serif] justify-center relative shrink-0 text-[#ff9644] text-[12px] cursor-pointer"
        >
          <p className="leading-[16px]">더보기</p>
        </button>
      </div>
      {recipes.map((recipe) => (
        <RecipeCard key={recipe.id} recipe={recipe} onClick={() => onRecipeClick(recipe)} />
      ))}
    </div>
  );
}

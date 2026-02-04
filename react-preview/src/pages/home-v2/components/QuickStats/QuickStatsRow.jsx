import { StatCard } from './StatCard';

export function QuickStatsRow({ stats, onStatClick }) {
  if (!stats) return null;

  return (
    <div className="content-stretch flex gap-[8px] items-center px-[20px] py-[12px] relative shrink-0 w-full">
      <StatCard
        type="water"
        label={stats.water.label}
        value={stats.water.value}
        unit={stats.water.unit}
        onClick={() => onStatClick('water')}
      />
      <StatCard
        type="steps"
        label={stats.steps.label}
        value={stats.steps.value}
        unit={stats.steps.unit}
        onClick={() => onStatClick('steps')}
      />
      <StatCard
        type="calories"
        label={stats.calories.label}
        value={stats.calories.value}
        unit={stats.calories.unit}
        onClick={() => onStatClick('calories')}
      />
    </div>
  );
}

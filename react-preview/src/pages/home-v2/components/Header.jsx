import { images } from '../constants/images';

export function Header({ user, onNotificationClick }) {
  if (!user) return null;

  return (
    <div className="content-stretch flex gap-[16px] h-[56px] items-center px-[20px] relative shrink-0 w-full">
      <div className="content-stretch flex flex-[1_0_0] gap-[8px] items-center min-h-px min-w-px relative">
        <div className="relative shrink-0 size-[40px]">
          <img
            alt="프로필"
            className="block max-w-none size-full rounded-full object-cover"
            src={user.profileImage}
          />
        </div>
        <div className="flex flex-col font-['Pretendard:SemiBold',sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2a2a2a] text-[18px] text-center whitespace-nowrap">
          <p className="leading-[24px]">안녕하세요, {user.name}님!</p>
        </div>
      </div>
      <button
        onClick={onNotificationClick}
        className="overflow-clip relative shrink-0 size-[24px] cursor-pointer"
      >
        <img alt="알림" className="block max-w-none size-full" src={images.icons.notification} />
      </button>
    </div>
  );
}

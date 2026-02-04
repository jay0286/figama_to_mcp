import { images } from '../constants/images';

export function StatusBar() {
  return (
    <div className="content-stretch flex h-[32px] items-center justify-between px-[20px] relative shrink-0 w-full">
      <div className="h-[8.991px] relative shrink-0 w-[30.548px]">
        <img alt="시간" className="block max-w-none size-full" src={images.statusBar.time} />
      </div>
      <div className="content-stretch flex gap-[3.068px] items-start relative shrink-0">
        <div className="relative shrink-0 size-[18px]">
          <img alt="WiFi" className="block max-w-none size-full" src={images.statusBar.wifi} />
        </div>
        <div className="relative shrink-0 size-[18px]">
          <img alt="신호" className="block max-w-none size-full" src={images.statusBar.signal} />
        </div>
        <div className="relative shrink-0 size-[18.75px]">
          <img alt="배터리" className="block max-w-none size-full" src={images.statusBar.battery} />
        </div>
      </div>
    </div>
  );
}

package com.xiaomu.component
{
	public class ActionChoose extends DropList
	{
		public function ActionChoose()
		{
			super();
			width =  40;
			height = 30;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xf2f2f2);
			//			graphics.lineStyle(0xdddddd);
			graphics.drawRoundRect(0,0,width,height,10,10);
			graphics.endFill();
		}
	}
}
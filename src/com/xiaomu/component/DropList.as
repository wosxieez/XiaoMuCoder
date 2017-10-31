package com.xiaomu.component
{
	import coco.component.DropDownList;
	
	public class DropList extends DropDownList
	{
		public function DropList()
		{
			super();
			width = 75;
			height = 36;
			fontFamily = "Microsoft yahei";
			color = 0xA0A0A0;
			fontSize = 16;
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
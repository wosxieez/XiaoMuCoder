package com.xiaomu.component
{
	import coco.core.UIComponent;
	
	public class DialogSelect extends TextInputs
	{
		public function DialogSelect()
		{
			super();
			
//			width = 60;
			height = 30;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab.fontFamily = "Microsoft yahei";
			lab.color = 0x474747;
			lab.fontSize = fontSize;
		}
		
		override protected  function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab.x =(width-fontSize)/2-4;
			lab.y =(height - fontSize)/2-7;	
		}
		
		override protected function drawSkin():void
		{
			// over FFFDF9
			// normal F8F3E4
			graphics.clear();
			graphics.lineStyle(1, 0xF0E7CC);
			graphics.beginFill(0xFFFCFA);
			graphics.drawRoundRectComplex(0,0,width,height-4,15,15,15,15);
			graphics.endFill();
		}
	}
}
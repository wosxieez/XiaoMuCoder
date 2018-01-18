package com.xiaomu.component
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.Panel;
	
	public class NoticePanel extends Panel
	{
		public function NoticePanel()
		{
			super();
			width = 300;
			height = 50;
			titleHeight = 0;
			autoDrawSkin = false;
		}
		
		private var lab : Label;
		private var imgIcon : Image;
		
		override protected function createChildren():void
		{
		    super.createChildren();
			
			lab = new Label();
			lab.text = "请至少保证有一个皮肤哦~";
			lab.fontFamily ="Microsoft YaHei";
			lab.fontSize = 18;
			lab.color = 0xFF6347;
			addChild(lab);
			
			imgIcon = new Image();
			imgIcon.source = "assets/bear.png";
			addChild(imgIcon);
		}
		
		override protected function updateDisplayList():void
		{
		    super.updateDisplayList();
			
			lab.x = 68;
			lab.y = 10;
			
			imgIcon.width = 50;
			imgIcon.height = 60;
			imgIcon.x = 17;
			imgIcon.y = 9;
		}
		
		override protected function drawSkin():void
		{
		    super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(2,0x998457);
			graphics.beginFill(0xFFFAF4);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
		}
	}
}
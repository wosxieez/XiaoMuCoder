package com.xiaomu.renderer
{
	import flash.events.MouseEvent;
	
	import coco.component.TextAlign;
	import coco.component.DefaultItemRenderer;
	
	public class SelectboxRender extends DefaultItemRenderer
	{
		public function SelectboxRender()
		{
			super();
			buttonMode = true;
			autoDrawSkin = false;
			addEventListener(MouseEvent.MOUSE_OVER,this_rollOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT,this_rollOutHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontSize=15;
			labelDisplay.color = 0x965E21;
			labelDisplay.x = 16;
			labelDisplay.fontFamily = "Microsoft YaHei";
			labelDisplay.textAlign = TextAlign.JUSTIFY;
			
		}
		
		
		private var mouseOver:Boolean = false;
		override protected  function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(mouseOver ? 0xFFCA32:0xfffbf0);
			graphics.lineStyle(1, 0x965E21,0.1);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		protected function this_rollOutHandler(event:MouseEvent):void
		{
			mouseOver = false;
			invalidateSkin();
		}
		
		protected function this_rollOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
			invalidateSkin();
		}
	}
}
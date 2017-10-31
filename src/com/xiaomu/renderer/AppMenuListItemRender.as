package com.xiaomu.renderer
{
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	
	public class AppMenuListItemRender extends DefaultItemRenderer
	{
		public function AppMenuListItemRender()
		{
			super();
			buttonMode = true;
			autoDrawSkin = false;
			addEventListener(MouseEvent.MOUSE_OVER,this_rollOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT,this_rollOutHandler);
		}
		
		private var img:Image;
		private var source:String;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontSize=15;
			labelDisplay.color = 0x965E21;
			labelDisplay.x = 20;
			labelDisplay.fontFamily = "Microsoft YaHei";
			labelDisplay.textAlign = TextAlign.LEFT;
			
			img = new Image();
			
			addChild(img);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			img.x = 6;
			img.height = 3;
			
		}
		private var mouseOver:Boolean = false;
		override protected  function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(mouseOver ? 0xfaf4e4:0xfffbf0);
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
package com.xiaomu.renderer
{
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.TextAlign;
	
	public class ListItemRenderer extends DefaultItemRenderer
	{
		public function ListItemRenderer()
		{
			super();
			buttonMode = true;
			autoDrawSkin = false;
			
			addEventListener(MouseEvent.ROLL_OVER, this_rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, this_rollOutHandler);
		}
		
		
		private var _mouseOver:Boolean = false;
		
		public function get mouseOver():Boolean
		{
			return _mouseOver;
		}
		
		public function set mouseOver(value:Boolean):void
		{
			_mouseOver = value;
			invalidateProperties();
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontSize=15;
			labelDisplay.fontFamily = "Microsoft YaHei";
			labelDisplay.x = 20;
			labelDisplay.textAlign = TextAlign.LEFT;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (mouseOver)
				labelDisplay.color = 0x3399CC;
			else
				labelDisplay.color = 0x666666;
		}
		
		protected function this_rollOutHandler(event:MouseEvent):void
		{
			mouseOver = false;
		}
		
		protected function this_rollOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
		}
		
		
	}
}
package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	
	public class StatusButton extends Button
	{
		public function StatusButton()
		{
			super();
			buttonMode = true;
			fontFamily = "Microsoft YaHei"
			fontSize = 18;
			autoDrawSkin = false;
			addEventListener(MouseEvent.CLICK,clickHandler);
		}

		private var _select : Boolean ;

		public function get select():Boolean
		{
			return _select;
		}

		public function set select(value:Boolean):void
		{
			_select = value;
			invalidateSkin();
			invalidateProperties();
		}

		
		protected function clickHandler(event:MouseEvent):void
		{
			select = true;
		}		
		
		override protected function commitProperties():void
		{
		    super.commitProperties();
			color = select ? 0x666666 : 0x999999;
		}
		
		override protected function drawSkin():void
		{
		    super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(select ? 0xFAF4E4 : 0xFFFBF0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}
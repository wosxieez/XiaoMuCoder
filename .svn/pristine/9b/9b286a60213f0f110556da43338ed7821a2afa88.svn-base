package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	
	public class BarButton extends Button
	{
		public function BarButton()
		{
			super();
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER , mouseOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
		}
		
		private var lab : Label;
		private var icon : Image;
		private var mouseOver : Boolean = false;
		
		private var _labtext : String;

		public function get labtext():String
		{
			return _labtext;
		}

		public function set labtext(value:String):void
		{
			_labtext = value;
			invalidateProperties();
			invalidateDisplayList();
		}
		
		private var _source : String;

		public function get source():String
		{
			return _source;
		}

		public function set source(value:String):void
		{
			_source = value;
			invalidateProperties();
		}
		
		override protected function createChildren():void
		{
		    super.createChildren();
			
			icon = new Image();
			icon.width = icon.height = 30;
			addChild(icon);
			
			lab = new Label();
			addChild(lab);
		}
		
		override protected function commitProperties():void
		{
		    super.commitProperties();
			
			lab.text =labtext;
			lab.fontFamily = "Microsoft YaHei";
			lab.fontSize = 16;
			lab.color = 0x837664;
			icon.source = source;
		}
		
		
		override protected function updateDisplayList():void
		{
		    super.updateDisplayList();
			
			if(lab.text!="")
			{
				icon.x = 50 ;
				lab.x= icon.x + 50;
				lab.y= (height - lab.height)/2;
			}
			else
			{
				icon.x = (width-icon.width)/2 ;
			}
			
			icon.y = (height - icon.height)/2;
		}
		
		override protected function drawSkin():void
		{
		    super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(mouseOver ?   0xFFFFFF : 0xFFFBF0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		override protected function measure():void
		{
		    super.measure();
			measuredWidth = 100;
			measuredHeight =30;
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			mouseOver = false;
			invalidateSkin();
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
			invalidateSkin();
		}
	}
}
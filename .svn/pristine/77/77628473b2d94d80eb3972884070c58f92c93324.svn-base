package com.xiaomu.component
{
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class ItemButton extends UIComponent
	{
		
		public function ItemButton()
		{
			super();
			
			width = 100;
			height = 30;
		}
		
		//先加图片，还有文本
		private var img1:Image,lab1:Label;
		
		private var _bgcolor:uint;
		
		public function get bgcolor():uint
		{
			return _bgcolor;
		}

		public function set bgcolor(value:uint):void
		{
			_bgcolor = value;
		}

		private var _text:String;
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			invalidateProperties();
		}

		private var _source:String;
		public function get source():String
		{
			return _source;
		}

		public function set source(value:String):void
		{
			_source = value;
			invalidateProperties();
		}
		
		private var _selected:Boolean = false;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			invalidateProperties();
			invalidateSkin();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			img1 = new Image();
			addChild(img1);
			
			lab1 = new Label();
			addChild(lab1);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			img1.source = source;
			
			lab1.text = text;	
			lab1.fontSize = 15;
			lab1.fontFamily = "Microsoft yahei";
			if(selected)
			{
				lab1.color = 0xffffff;
			}
			else
			{
				lab1.color = 0x776955;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			img1.x = 7;
			img1.y = 6;
			
			lab1. x = 40;
			lab1. y = 8;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.beginFill(bgcolor);
			graphics.lineStyle(1,0xF2E7C9);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
			
			if (!selected)
			{
				graphics.beginFill(0xFFFBF0);
				graphics.drawRect(10,0,width - 10,height);
				graphics.endFill();
			}
			
		}
		
	}
}
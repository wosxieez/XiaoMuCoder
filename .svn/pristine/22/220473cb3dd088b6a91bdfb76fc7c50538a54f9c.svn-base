package com.xiaomu.component
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class TextInputChange extends TextInput
	{
		private var focusIn : Boolean = false;
		
		public function TextInputChange()
		{
			super();
			addEventListener(FocusEvent.FOCUS_IN , focusInHandler);
			addEventListener(FocusEvent.FOCUS_OUT , focusOutHandler);
			addEventListener(Event.CHANGE , changeHandler);
		}
		
		protected function changeHandler(event:Event):void
		{
			if(text=="")
				lab.visible = true;
			else
			{
			    lab.visible = false;
			}
		}
		
		protected function focusOutHandler(event:FocusEvent):void
		{
			if(text!="")
			lab.visible = false;
			else
			{
			    lab.visible = true;
			}
			focusIn = false;
			invalidateSkin();
		}
		
		protected function focusInHandler(event:FocusEvent):void
		{
			focusIn = true;
			invalidateSkin();
		}
		
		private var lab : Label;
		
		private var _textLab : String;

		public function get textLab():String
		{
			return _textLab;
		}

		public function set textLab(value:String):void
		{
			_textLab = value;
		}
		
		override protected function createChildren():void
		{
		    super.createChildren();
			
			lab = new Label();
			lab.text = textLab ;
			addChild(lab);
		}
		
		override protected function commitProperties():void
		{
		    super.commitProperties();
			
			lab.fontSize = fontSize;
			lab.fontFamily = fontFamily;
			lab.color = color;
		}
		
		override protected function updateDisplayList():void
		{
		    super.updateDisplayList();
			
			lab.x = 10;
			lab.y =(height - fontSize)/2-6;
		}

		override protected function drawSkin():void
		{
		    super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1, focusIn ?  0x4FADFF : 0x888888);
			graphics.beginFill(focusIn? 0xFFFFFF: 0xF8F3EA);
			graphics.drawRoundRectComplex(0,0,width,height,topLeftRadius,topRightRadius,bottomLeftRadius,bottomRightRadius);
			graphics.endFill();
		}
	}
}
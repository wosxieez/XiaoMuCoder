package com.xiaomu.view.headview
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class InputText extends TextInput
	{
		private var focusIn : Boolean = false;
		public function InputText()
		{
			super();
			wordWrap = true;
			height=30;
			addEventListener(FocusEvent.FOCUS_IN , focusInHandler);
			addEventListener(FocusEvent.FOCUS_OUT , focusOutHandler);
			addEventListener(Event.CHANGE , changeHandler);
		}
		
		public function get labelText():String
		{
			return _labelText;
		}
		
		public function set labelText(value:String):void
		{
			_labelText = value;
			invalidateProperties();
		}
		
		protected function focusInHandler(event:FocusEvent):void
		{
			focusIn = true;
			invalidateSkin();
			
		}
		protected function changeHandler(event:Event):void
		{
			if(text != "")
			{
				lab.visible = false;
			}
			else
			{
				lab.visible = true;
			}
			
		}
		
		protected function focusOutHandler(event:FocusEvent):void
		{
			if(text == "")
			{
				lab.visible =true ;
			}
			else
			{
				lab.visible = false;
			}
			focusIn = false;
			invalidateSkin();
		}
		
		
		private var lab : Label;
		private var _labelText : String;
		
		override protected  function createChildren():void
		{
			super.createChildren();
			lab = new Label();
			lab.text = labelText;
			addChild(lab);
		}
		
		override protected  function commitProperties():void
		{
			super.commitProperties();
			lab.fontFamily = fontFamily;
			lab.color = color;
			lab.fontSize = fontSize;
		}
		
		override protected  function updateDisplayList():void
		{
			super.updateDisplayList();
			lab.x = 10;
			lab.y =(height - lab.height)/2-12;	
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1, focusIn ?  0x4FADFF : 0x888888,0.1);
			graphics.beginFill(focusIn? 0xF8F3EA:0xFAC001);
			graphics.drawRoundRectComplex(0,0,width,height,4,4,4,4);
			graphics.endFill();
		}
	}
}
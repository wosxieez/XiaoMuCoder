package com.xiaomu.component
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class TextInputs extends TextInput
	{
		private var focusIn : Boolean = false;
		public function TextInputs()
		{
			super();
			
			wordWrap = true;
			fontSize = 15;
			fontFamily = "Microsoft yahei";
			width = 400;
			height=34;
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
		
		
		protected var lab : Label;
		protected var _labelText : String;
		
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
			lab.fontFamily = "Microsoft yahei";
			lab.color = 0xCFCFCF;
			lab.fontSize = 15;
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
			graphics.lineStyle(1, focusIn ?  0xFCDD85 : 0xD9EADC);
			graphics.beginFill( 0xF8F3EA ,0.5);
			graphics.drawRoundRectComplex(0,0,width,height,4,4,4,4);
			graphics.endFill();
		}
	}
}
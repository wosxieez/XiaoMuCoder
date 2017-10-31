package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;

	public class Listcenterbutton extends Button
	{
		public function Listcenterbutton()
		{
			super();
			addEventListener(MouseEvent.MOUSE_OVER,mouseOver_handle);
			addEventListener(MouseEvent.MOUSE_OUT,mouseOut_handle);
		}
		
		private var mouseOver:Boolean = false;
		private var _mouseOverColor:uint ;
		private var _mouseOutColor:uint ;
		
		protected function mouseOut_handle(event:MouseEvent):void
		{
			mouseOver = false;
			invalidateSkin();
		}
		
		protected function mouseOver_handle(event:MouseEvent):void
		{
			mouseOver = true;
			invalidateSkin();
			
		}
		
		
		private var _text:String;
		private var _source:String;
		
		public function get mouseOutColor():uint
		{
			return _mouseOutColor;
		}
		
		public function set mouseOutColor(value:uint):void
		{
			_mouseOutColor = value;
			invalidateSkin();
		}
		
		public function get mouseOverColor():uint
		{
			return _mouseOverColor;
		}
		
		public function set mouseOverColor(value:uint):void
		{
			_mouseOverColor = value;
			invalidateSkin();
		}
		
		public function get source():String
		{
			return _source;
		}
		
		public function set source(value:String):void
		{
			_source = value;
			invalidateProperties();
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			invalidateProperties();
		}
		
		private var lab:Label;
		private var img:Image;
		override protected  function createChildren():void
		{
			super.createChildren();
			lab = new Label();
			addChild(lab);
			
			img = new Image();
			addChild(img);
		}
		
		override protected  function commitProperties():void
		{
			super.commitProperties();
			lab.text = _text;
			img.source = source;
			
		}
		
		override protected  function updateDisplayList():void
		{
			super.updateDisplayList();
			img.x = 16;
			img.y = (height-img.height)/2;
			
			lab.x = (width - fontSize)/2-10;
			lab.fontFamily = "Microsoft yahei";
			lab.fontSize = fontSize;
			lab.color = color;
			lab.y = (height- lab.height)/2-1;
			
		}
		
		//		
		override protected function drawSkin():void
		{
			super.drawSkin();
			graphics.clear();
			graphics.beginFill(mouseOver ? _mouseOverColor : _mouseOutColor);
			graphics.lineStyle(1,0x965E21,0.1);
			graphics.drawRoundRect(0,0,width,height,6,6);
			graphics.endFill();
		}	
	}
}
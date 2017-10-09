package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	public class RadiusButton extends UIComponent
	{
		public function RadiusButton()
		{
			super();
			addEventListener(MouseEvent.ROLL_OVER, RollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT , rollOutHandler);
			addEventListener(MouseEvent.MOUSE_DOWN , downHandler);
			addEventListener(MouseEvent.MOUSE_UP,upHandler);
		}
		
		private var mouseOver : Boolean = false;
		private var mouseDown : Boolean = false;
		
		private var mouseOutImg : Image;
		private var mouseOverImg : Image;
		
		private var _mouseOverSource : String;

		public function get mouseOverSource():String
		{
			return _mouseOverSource;
		}

		public function set mouseOverSource(value:String):void
		{
			_mouseOverSource = value;
			invalidateProperties();
		}
		
		private var _mouseOutSource : String;
		
		public function get mouseOutSource():String
		{
			return _mouseOutSource;
		}
		
		public function set mouseOutSource(value:String):void
		{
			_mouseOutSource = value;
			invalidateProperties();
		}

		private var _topLeftRadius : Number = 0;

		public function get topLeftRadius():Number
		{
			return _topLeftRadius;
		}

		public function set topLeftRadius(value:Number):void
		{
			_topLeftRadius = value;
			invalidateSkin();
		}

		private var _topRightRadius : Number = 0;

		public function get topRightRadius():Number
		{
			return _topRightRadius;
		}

		public function set topRightRadius(value:Number):void
		{
			_topRightRadius = value;
			invalidateSkin();
		}

		private var _bottomLeftRadius : Number = 0;

		public function get bottomLeftRadius():Number
		{
			return _bottomLeftRadius;
		}

		public function set bottomLeftRadius(value:Number):void
		{
			_bottomLeftRadius = value;
			invalidateSkin();
		}

		private var _bottomRightRadius : Number = 0;

		public function get bottomRightRadius():Number
		{
			return _bottomRightRadius;
		}

		public function set bottomRightRadius(value:Number):void
		{
			_bottomRightRadius = value;
			invalidateSkin();
		}
		
		protected function rollOutHandler(event:MouseEvent):void
		{
			mouseOver = false;
			invalidateProperties();
			invalidateSkin();
		}
		
		protected function RollOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
			invalidateProperties();
			invalidateSkin();
		}
		
		protected function upHandler(event:MouseEvent):void
		{
			mouseDown = false;
			invalidateSkin();
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			mouseDown = true;
			invalidateSkin();
		}
		
		
		override protected function createChildren():void
		{
		    super.createChildren();
			
			mouseOverImg = new Image();
			mouseOverImg.width = mouseOverImg.height = 30;
			mouseOverImg.source = mouseOverSource;
			
			mouseOutImg = new Image();
			mouseOutImg.width = mouseOutImg.height = 30;
			mouseOutImg.source = mouseOutSource;
		}
		
		override protected function commitProperties():void
		{
		    super.commitProperties();
			
			if(mouseOver)
			{
			    addChild(mouseOverImg);
			}
			else
			{
				addChild(mouseOutImg);
			}
		}
		
		override protected function updateDisplayList():void
		{
		    super.updateDisplayList();
			
			mouseOutImg.x=mouseOverImg.x = (width - mouseOverImg.width)/2;
			mouseOutImg.y=mouseOverImg.y = (height - mouseOverImg.height)/2;
		}
		
		override protected function measure():void
		{
		    super.measure();
			
			measuredWidth = measuredHeight =30;
		}
		
		override protected function drawSkin():void
		{
		    super.drawSkin();
			
			if(mouseOver)
			{
				graphics.clear();
				graphics.lineStyle(1,0x999999);
				graphics.beginFill(mouseDown ? 0x4FADFF  : 0x81D4FA);
				graphics.drawRoundRectComplex(0,0,width,height,_topLeftRadius,_topRightRadius,bottomLeftRadius,bottomRightRadius);
				graphics.endFill();		
			}
			else
			{
				graphics.clear();
				graphics.lineStyle(1,0x999999);
				graphics.beginFill(0xF8F3EA);
				graphics.drawRoundRectComplex(0,0,width,height,_topLeftRadius,_topRightRadius,bottomLeftRadius,bottomRightRadius);
				graphics.endFill();		
			}
		}
		
	}
}
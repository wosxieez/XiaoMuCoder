package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	
	
	/**
	 * 图标按钮 
	 * @author coco
	 */	
	public class IconButton extends UIComponent
	{
		public function IconButton()
		{
			super();
			
			width = 32;
			height = 32;
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_OVER, this_mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, this_mouseOutHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, this_mouseUpHandler);
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		protected var imageDisplay:Image;
		
		//-----------------
		// source
		//-----------------
		
		private var _source:Object;
		
		public function get source():Object
		{
			return _source;
		}
		
		public function set source(value:Object):void
		{
			if (_source == value) return;
			_source = value;
			invalidateProperties();
		}
		
		//-----------------
		// mouseOver
		//-----------------
		
		private var _mouseOver:Boolean = false;
		
		public function get mouseOver():Boolean
		{
			return _mouseOver;
		}
		
		public function set mouseOver(value:Boolean):void
		{
			if (_mouseOver == value) return;
			_mouseOver = value;
			invalidateSkin();
		}
		
		//-----------------
		// mouseDown
		//-----------------
		
		private var _mouseDown:Boolean = false;
		
		public function get mouseDown():Boolean
		{
			return _mouseDown;
		}
		
		public function set mouseDown(value:Boolean):void
		{
			if (_mouseDown == value) return;
			_mouseDown = value;
			invalidateSkin();
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			imageDisplay = new Image();
			imageDisplay.width = imageDisplay.height = 24;
			addChild(imageDisplay);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			imageDisplay.source = source;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			imageDisplay.x = (width - imageDisplay.width) / 2;
			imageDisplay.y = (height - imageDisplay.height) / 2;
		}
		
		override protected function drawSkin():void
		{
			// over FFFDF9
			// normal F8F3E4
			graphics.clear();
			if (mouseOver && !mouseDown)
				graphics.beginFill(0xFFFDF9, .2);
			else
				graphics.beginFill(0xF8F3E4, 0);
			graphics.drawRoundRectComplex(0, 0, width, height, 2, 2, 2, 2);
			graphics.endFill();
		}
		
		protected function this_mouseOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
		}
		
		protected function this_mouseOutHandler(event:MouseEvent):void
		{
			mouseOver = mouseDown = false;
		}	
		
		protected function this_mouseDownHandler(event:MouseEvent):void
		{
			mouseDown = true;
		}
		
		protected function this_mouseUpHandler(event:MouseEvent):void
		{
			mouseDown = false;
		}
		
	}
}

package com.xiaomu.renderer
{
	import flash.geom.ColorTransform;
	
	import coco.component.IItemRenderer;
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class ActionBarItemRenderer extends UIComponent implements IItemRenderer
	{
		
		public function ActionBarItemRenderer()
		{
			super();
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var oldColorTransform:ColorTransform;
		private var imageDisplay:Image;
		private var labelDisplay:Label;
		
		private var _data:Object;
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			if (_data == value) return;
			_data = value;
			invalidateProperties();
		}
		
		
		private var _index:int = -1;
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		
		private var _selected:Boolean= false;
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if (_selected == value) return;
			_selected = value;
			invalidateSkin();
		}
		
		
		private var _labelField:String;
		
		public function get labelField():String
		{
			return _labelField;
		}
		
		public function set labelField(value:String):void
		{
			if (_labelField == value) return;
			_labelField = value;
			invalidateProperties();
		}
		
		private var _backgroundColor:uint = 0x000000;

		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			if (_backgroundColor == value) return;
			_backgroundColor = value;
			
			invalidateSkin();
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			imageDisplay = new Image();
			imageDisplay.width = imageDisplay.height = 16;
			oldColorTransform = imageDisplay.transform.colorTransform;
			addChild(imageDisplay);
			
			labelDisplay = new Label();
			labelDisplay.fontSize = 15;
			labelDisplay.letterSpacing = 2;
			addChild(labelDisplay);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				imageDisplay.source = data.source;
				labelDisplay.text = data.name;
				backgroundColor = data.color;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			imageDisplay.x = (height - imageDisplay.width) / 2 + 10;
			imageDisplay.y = (height - imageDisplay.height) / 2;
			
			labelDisplay.x = 10 + height * 2 / 3;
			labelDisplay.width = width - labelDisplay.x;
			labelDisplay.height = height;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.beginFill(backgroundColor);
			graphics.lineStyle(1,0xEEE6C9);
			graphics.drawRoundRectComplex(0, 0, width, height, 2, 2, 2, 2);
			graphics.endFill();
			
			if (!selected)
			{
				graphics.beginFill(0xFFFBF0);
				graphics.drawRoundRectComplex(10,0,width - 10,height, 0, 2, 0, 2);
				graphics.endFill();
				
				imageDisplay.transform.colorTransform = oldColorTransform;
				labelDisplay.color = 0x857C6A;
			}
			else
			{
				var newColorTransform:ColorTransform = imageDisplay.transform.colorTransform;
				newColorTransform.color = 0xFFFFFF;
				imageDisplay.transform.colorTransform = newColorTransform;
				labelDisplay.color = 0xFFFFFF;
			}
			
		}
		
	}
}
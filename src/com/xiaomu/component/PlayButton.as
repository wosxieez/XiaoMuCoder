package com.xiaomu.component
{
	import flash.events.MouseEvent;
	
	import coco.component.Button;
	import coco.component.Image;
	import coco.component.Label;
	
	public class PlayButton extends Button
	{
		public function PlayButton()
		{
			super();
			buttonMode = true;
			width = 66;
			height = 26;
			addEventListener(MouseEvent.ROLL_OVER , mouseOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
		}
		
		
		private var label1: Label;
		public var source : String;
		public var bgcolor:uint;
		public var selectedBgColor:uint;
		private var mouseOver : Boolean = false;;
		private var img1 :  Image;
		public var selectedSource:String;
		public var selectedText:String;
		public var text:String;
		
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
		
		override protected  function createChildren():void
		{
			super.createChildren();
			
			label1 = new Label();
			addChild(label1);
			
			img1 = new Image();
			addChild(img1);
		}
		
		override protected  function commitProperties():void
		{
			super.commitProperties();
			label1.text = selected? selectedText : text;
			label1.fontSize = 13;
			label1.color = 0xffffff;
			label1.fontFamily = "Microsoft yahei";
			
			img1.source =  selected ? selectedSource : source;
		}
		
		override protected  function updateDisplayList():void
		{
			super.updateDisplayList();
			label1.x = 30;
			label1.y = 2;
			img1.x = 8;
			img1.y = 5;
		}
		
		override protected  function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(mouseOver ? 0x74B2FE:0x60A1F0);
			graphics.lineStyle(1,0xF2E7C9);
			graphics.drawRoundRect(0,0,width,height,6,6);
			graphics.endFill();
		}
	}
}
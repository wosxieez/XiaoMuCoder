package com.xiaomu.component
{
	import flash.display.GraphicsTrianglePath;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextArea;
	import coco.core.UIComponent;
	
	public class NewDialogComponent extends UIComponent
	{
		public function NewDialogComponent()
		{
			super();
			
			width = 380;
			height = 95;
		}
		
		private var textArea:TextArea;
		private var img:PicIconbtn;
		private var labDisplay:Label;
		
		private var _labtext:String;
		private var _imgsource:String;
		private var _textareaText:String;
		
		public function get textareaText():String
		{
			return _textareaText;
		}

		public function set textareaText(value:String):void
		{
			_textareaText = value;
		}

		public function get imgsource():String
		{
			return _imgsource;
		}

		public function set imgsource(value:String):void
		{
			_imgsource = value;
		}

		public function get labtext():String
		{
			return _labtext;
		}

		public function set labtext(value:String):void
		{
			_labtext = value;
		}

		override protected function createChildren():void {
			super.createChildren();
			
			textArea = new TextArea();
			textArea.width = width-80;
			textArea.height = 50;
			addChild(textArea);
			
			img = new PicIconbtn();
			addChild(img);
			
			labDisplay = new Label();
			labDisplay.height = 20;
			addChild(labDisplay);	
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			img.source = imgsource;
			img.radius = 30;
			
			labDisplay.text = labtext;
			labDisplay.color = 0x60A1F0;
			
			textArea.borderColor = 0xE6E6E3;
			textArea.text = textareaText;
			textArea.color = 0xA0A0A0;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			img.y = 20;
			labDisplay.x =textArea.x = 70;
			labDisplay.y = 3;
			
			textArea.y = labDisplay.height+6;
			
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF,0.5);
			graphics.lineStyle(1,0xE6E6E3);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}
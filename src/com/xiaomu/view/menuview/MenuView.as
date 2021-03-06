package com.xiaomu.view.menuview
{
	import com.xiaomu.component.IconButton;
	import com.xiaomu.util.Theme;
	
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class MenuView extends UIComponent
	{
		public function MenuView()
		{
			super();
			
			height = 40;
			
			addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler);
		}
		
		
		private var titleDisplay:Label;
		private var closeAppButton:IconButton;
		
		
		override  protected function createChildren():void
		{
			super.createChildren();
			
			titleDisplay = new Label();
			titleDisplay.text = "小木编程";
			titleDisplay.color = 0xFFFFFF;
			titleDisplay.fontSize = 15;
			titleDisplay.bold = true;
			titleDisplay.x = 15;
			addChild(titleDisplay);
			
			closeAppButton = new IconButton();
			closeAppButton.source = "assets/close1.png";
			closeAppButton.addEventListener(MouseEvent.CLICK, closeAppButton_clickHandler);
			addChild(closeAppButton);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			titleDisplay.height = height;
			
			closeAppButton.x = width - 30 - closeAppButton.width;//cmz修改前10
			closeAppButton.y = (height - closeAppButton.height) / 2;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.lineStyle(1, Theme.COLOR1);
			graphics.beginFill(Theme.COLOR1);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		protected function this_mouseDownHandler(event:MouseEvent):void
		{
			stage.nativeWindow.startMove();
		}
		
		protected function closeAppButton_clickHandler(event:MouseEvent):void
		{
			stage.nativeWindow.close();
		}
		
	}
}
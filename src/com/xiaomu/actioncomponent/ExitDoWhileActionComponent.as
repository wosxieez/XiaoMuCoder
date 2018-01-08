package com.xiaomu.actioncomponent
{
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class ExitDoWhileActionComponent extends ActionComponent
	{
		public function ExitDoWhileActionComponent()
		{
			super();
			
			width = 150;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
		}
		
		private var labelDisplay:Label;
		override protected function createChildren():void {
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.text = "退出循环";
			labelDisplay.fontFamily = "Microsoft yahei";
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.height = 30;
			addChild(labelDisplay);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			labelDisplay.width = width;
			
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			downHookComponent.y = height;
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(Theme.CONTROL_COLOR);
			graphics.drawRoundRectComplex(0, 0, width, height,0,15,0,15);
			graphics.drawRect(upHookComponent.x, upHookComponent.y, 10, 5);
			graphics.endFill();
			graphics.beginFill(downHookComponent.matchActionHook ? Theme.MATCHED_COLOR : Theme.CONTROL_COLOR);
			graphics.drawRect(downHookComponent.x, downHookComponent.y, 10, 5);
			graphics.endFill();
			
		}
	}
}
package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.MoveXAction;
	import com.xiaomu.action.XandYAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class XandYComponent extends ActionComponent
	{
		public function XandYComponent()
		{
			super();
			
			
			width = 160;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			actionClass = XandYAction;
		}
		
		private var labelDisplay:Label;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.fontFamily = "Microsoft yahei";
			labelDisplay.text = "移动到X:150,Y:150";
			addChild(labelDisplay);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			
			labelDisplay.width = width;
			labelDisplay.height = height;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(Theme.ACTION_COLOR);
			graphics.drawRoundRectComplex(0, 0, width, height,0,15,0,15);
			graphics.drawRect(upHookComponent.x, upHookComponent.y, 10, 5);
			graphics.endFill();
			graphics.beginFill(downHookComponent.matchActionHook ? Theme.MATCHED_COLOR : Theme.ACTION_COLOR);
			graphics.drawRect(downHookComponent.x, downHookComponent.y, 10, 5);
			graphics.endFill();
		}
	}
}
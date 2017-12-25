package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.Continue;
	import com.xiaomu.action.MoveXAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class ContinueComponent extends ActionComponent
	{
		private var upHookComponent1:UpHookComponent;
		private var downHookComponent1:DownHookComponent;
		public function ContinueComponent()
		{
			super();
			
			width = 150;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			upHookComponent1 = new UpHookComponent();
			upHookComponent1.x = 30;
			
			downHookComponent1 = new DownHookComponent();
			downHookComponent1.x = 30;
			
			actionClass = Continue;
		}
		
		private var labelDisplay:Label;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "重复执行";
			addChild(labelDisplay);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			upHookComponent1.y = height;
			
			labelDisplay.width = width;
			labelDisplay.height = height;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(Theme.CONTROL_COLOR);
			graphics.drawRoundRectComplex(0, 0, width, height,0,height/2,0,height/2);
			graphics.drawRect(upHookComponent.x, upHookComponent.y, 10, 5);
			graphics.endFill();
			graphics.beginFill(Theme.CONTROL_COLOR);
			graphics.drawRect(upHookComponent1.x, upHookComponent1.y, 10, 5);
			graphics.endFill();
			graphics.beginFill(Theme.CONTROL_COLOR);
			graphics.drawRect(0,height,15,30);
			graphics.drawRoundRectComplex(0, height+30, 80, 20,0,10,0,10);
			graphics.endFill();
			graphics.beginFill(0XFFFFFF);
			graphics.drawRect(downHookComponent1.x, downHookComponent1.y+60, 10, 5);
			graphics.endFill();
			graphics.beginFill(downHookComponent.matchActionHook ? Theme.MATCHED_COLOR : Theme.CONTROL_COLOR);
			graphics.drawRect(downHookComponent.x, downHookComponent.y+50, 10, 5);
			graphics.endFill();
		}
		
	}
}
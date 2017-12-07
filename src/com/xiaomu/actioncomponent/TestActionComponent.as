package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.TestAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownFlagHookComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.DropList;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.renderer.SelectboxRender;
	import com.xiaomu.util.Theme;
	
	import coco.component.DropDownList;
	import coco.component.Label;
	import com.xiaomu.component.ActionChoose;
	
	public class TestActionComponent extends ActionComponent
	{
		public function TestActionComponent()
		{
			super();
			
			width = 150;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			flagHookComponent1 = new DownFlagHookComponent();
			flagHookComponent1.x = 90;
			addDownFlagHookComponent(flagHookComponent1);
		
			actionClass = TestAction;
		}
		
		private var labelDisplay:Label;
//		private var rolePlay: ActionChoose;
//		private var arr1:Array = ["点击","按下","放开"];

		private var flagHookComponent1:DownFlagHookComponent;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "当角色被点击";
			addChild(labelDisplay);
			
//			rolePlay = new ActionChoose();
//			rolePlay.itemRendererClass = SelectboxRender;
//			rolePlay.dataProvider = arr1;
//			addChild(rolePlay);
			
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			
			labelDisplay.width = width;
			labelDisplay.height = height;
//			labelDisplay.x = 5;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(Theme.ACTION_COLOR);
			graphics.drawRect(0, 0, width, height);
			graphics.drawRect(upHookComponent.x, upHookComponent.y, 10, 5);
			graphics.endFill();
			graphics.beginFill(downHookComponent.matchActionHook ? Theme.MATCHED_COLOR : Theme.ACTION_COLOR);
			graphics.drawRect(downHookComponent.x, downHookComponent.y, 10, 5);
			graphics.endFill();
			graphics.beginFill(flagHookComponent1.matchActionHook ? Theme.MATCHED_COLOR : Theme.EVENT_COLOR);
			graphics.drawRoundRectComplex(flagHookComponent1.x, flagHookComponent1.y, 50, 30, 5, 5, 5, 5);
			graphics.endFill();
		}
		
	}
}
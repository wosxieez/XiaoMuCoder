package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.TestAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownFlagHookComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	import coco.component.Label;
	
	public class TestActionComponent extends ActionComponent
	{
		public function TestActionComponent()
		{
			super();
			
			width = 130;
			height = 32;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			flagHookComponent1 = new DownFlagHookComponent();
			flagHookComponent1.x = 60;
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
			labelDisplay.text = "当开始  被点击";
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
			
			labelDisplay.width = width-10;
			labelDisplay.height = height;
		}
		
		override protected function drawSkin():void
		{
			//先画圆
			graphics.clear();
			graphics.beginFill(Theme.EVENT_COLOR);
			graphics.lineStyle(2,downHookComponent.matchActionHook ? 0xFFCC33 : 0x5B87E1);
			graphics.drawCircle(-4,height/2-4,(height+8)/2);
			graphics.endFill();
			
			//画矩形，重贴边框部分重新画
			graphics.beginFill(Theme.EVENT_COLOR);
			graphics.drawRoundRectComplex(0, 0, width, height,0,16,0,16);
			graphics.lineStyle(2,Theme.EVENT_COLOR);
			graphics.moveTo(0,height-2);
			graphics.lineTo(0,0);
			graphics.lineTo(10,0);
			
			graphics.moveTo(downHookComponent.x,height);
			graphics.lineTo(downHookComponent.x+10,height);
			graphics.endFill();
			
			graphics.beginFill(Theme.EVENT_COLOR);
			graphics.lineStyle(2,downHookComponent.matchActionHook ? 0xFFCC33 : 0x5B87E1);
			graphics.drawRect(downHookComponent.x, downHookComponent.y, 10, 5);
			graphics.lineStyle(2,Theme.EVENT_COLOR);
			graphics.moveTo(downHookComponent.x+2,height);
			graphics.lineTo(downHookComponent.x+8,height);
			graphics.endFill();
			
//			graphics.beginFill(flagHookComponent1.matchActionHook ? Theme.MATCHED_COLOR : Theme.EVENT_COLOR);
//			graphics.drawRoundRectComplex(flagHookComponent1.x, flagHookComponent1.y, 50, 30, 5, 5, 5, 5);
//			graphics.endFill();
		}
		
	}
}
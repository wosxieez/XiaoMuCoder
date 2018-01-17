package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.ShowAfterMomentsAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DialogSelect;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class ShowAfterMomentsActionComponent extends ActionComponent
	{
		public function ShowAfterMomentsActionComponent()
		{
			super();
			
			width = 180;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			actionClass = ShowAfterMomentsAction;
		}
		
		private var labelDisplay:Label;
		private var labelDisplay1:Label;
		private var inputs:DialogSelect;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "在";
			labelDisplay.x = 34;
			labelDisplay.fontFamily = "Microsoft yahei";
			addChild(labelDisplay);
			
			labelDisplay1 = new Label();
			labelDisplay1.color = 0xFFFFFF;
			labelDisplay1.text = "秒内逐渐显示";
			labelDisplay1.fontFamily = "Microsoft yahei";
			addChild(labelDisplay1);
			
			inputs = new DialogSelect();
			inputs.labelText = "1";
			addChild(inputs);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			
			labelDisplay.height = labelDisplay1.height = height;
			
			labelDisplay1.x = 92;
			
			inputs.x = labelDisplay.fontSize+labelDisplay.x+5;
			inputs.y = 1;
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			inputs.width = 40;
			inputs.height = 30;
			inputs.fontSize = 14;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(Theme.SKIN_COLOR);
			graphics.lineStyle(2,downHookComponent.matchActionHook ? 0xFFCC33 : 0xD695C4);
			graphics.moveTo(0,0);
			graphics.lineTo(upHookComponent.x-3,0);
			graphics.lineTo(upHookComponent.x,6);
			graphics.lineTo(upHookComponent.x+7,6);
			graphics.lineTo(upHookComponent.x+10,0);
			graphics.lineTo(width-15,0);
			
			graphics.curveTo(width,2,width,15);
			graphics.curveTo(width,30,width-16,30);
			
			graphics.lineTo(width-15,height);
			graphics.lineTo(downHookComponent.x+10,height);
			graphics.lineTo(downHookComponent.x+7,height+6);
			graphics.lineTo(downHookComponent.x,height+6);
			graphics.lineTo(downHookComponent.x-3,height);
			graphics.lineTo(0,height);
			graphics.lineTo(0,0);
			graphics.endFill();
		}
	}
}
package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.AddSizeAction;
	import com.xiaomu.action.MoveToXAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DialogSelect;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class AddSizeActionComponent extends ActionComponent
	{
		public function AddSizeActionComponent()
		{
			super();
			
			width = 180;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			actionClass = 	AddSizeAction;
		}
		
		private var labelDisplay:Label;
		private var inputs:DialogSelect;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "将角色大小增加 ";
			labelDisplay.fontFamily = "Microsoft yahei";
			addChild(labelDisplay);
			
			inputs = new DialogSelect();
			inputs.labelText = "10";
			addChild(inputs);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			inputs.width = 45;
			inputs.height = 28;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			
			labelDisplay.width = width-25;
			labelDisplay.height = height;
			
			inputs.x = labelDisplay.width-30;
			inputs.y = 2;
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
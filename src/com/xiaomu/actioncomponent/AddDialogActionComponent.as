package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.MoveXAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DialogSelect;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	import com.xiaomu.view.headview.InputText;
	
	import coco.component.Label;
	
	public class AddDialogActionComponent extends ActionComponent
	{
		public function AddDialogActionComponent()
		{
			super();
			
			width = 180;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
//			actionClass = MoveXAction;
		}
		
		private var labelDisplay:Label;
		private var inputs:DialogSelect;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "新建对话框  ";
			labelDisplay.fontFamily = "Microsoft yahei";
			addChild(labelDisplay);
			
			inputs = new DialogSelect();
			inputs.width = 60;
			inputs.labelText = "Hi";
			addChild(inputs);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			
			labelDisplay.width = width-50;
			labelDisplay.height = height;
			
			inputs.x = width-76;
			inputs.y = 1;
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
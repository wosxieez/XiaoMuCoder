package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.MoveXAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.TextInputs;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	import com.xiaomu.view.headview.InputText;
	
	import coco.component.Label;
	import coco.component.TextInput;
	
	public class MoveXActionComponent extends ActionComponent
	{
		public function MoveXActionComponent()
		{
			super();
			
			width = 160;
			height = 30;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
		
			actionClass = MoveXAction;
		}
		
		private var labelDisplay:Label;
		private var inputs:InputText;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "将X坐标增加  ";
			labelDisplay.fontFamily = "Microsoft yahei";
			addChild(labelDisplay);
			
			inputs = new InputText();
			inputs.width = 40;
			inputs.labelText = "100";
			addChild(inputs);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			downHookComponent.y = height;
			
			labelDisplay.width = width-30;
			labelDisplay.height = height;
			
			inputs.x = width-56;
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
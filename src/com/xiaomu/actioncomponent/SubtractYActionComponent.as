package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.SubtractXAction;
	import com.xiaomu.action.SubtractYAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.util.Theme;
	import com.xiaomu.view.headview.InputText;
	
	import coco.component.Label;
	
	public class SubtractYActionComponent extends ActionComponent
	{
		public function SubtractYActionComponent()
		{
			super();
			
			width = 160;
			height = 30 ;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			
			actionClass = SubtractYAction;
		}
		
		private var labelDisplay:Label;
		private var inputs:InputText;
		override protected function commitProperties():void {
			super.commitProperties();
			
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "Y坐标- ";
			labelDisplay.fontFamily = "Microsoft yahei";
			addChild(labelDisplay);
			
			inputs = new InputText();
			inputs.width = 40;
			inputs.labelText = "100";
			addChild(inputs);
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			labelDisplay.width = width-30;
			labelDisplay.height = height;
			
			downHookComponent.y = height;
			
			inputs.x = width-56;
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
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
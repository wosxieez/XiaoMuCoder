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
			graphics.lineStyle(2,downHookComponent.matchActionHook ? 0xFFCC33 : 0x5FB7E4,0.7);
			graphics.moveTo(0,0);
			graphics.lineTo(upHookComponent.x,0);
			graphics.lineTo(upHookComponent.x,5);
			graphics.lineTo(upHookComponent.x+10,5);
			graphics.lineTo(upHookComponent.x+10,0);
			graphics.lineTo(width-15,0);
			
			graphics.curveTo(width,2,width,15);
			graphics.curveTo(width,30,width-16,30);
			
			graphics.lineTo(width-15,height);
			graphics.lineTo(downHookComponent.x+10,height);
			graphics.lineTo(downHookComponent.x+10,height+5);
			graphics.lineTo(downHookComponent.x,height+5);
			graphics.lineTo(downHookComponent.x,height);
			graphics.lineTo(0,height);
			graphics.lineTo(0,0);
			graphics.endFill();
			
		}
	}
}
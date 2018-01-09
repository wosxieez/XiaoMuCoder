package com.xiaomu.actioncomponent
{
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.event.ActionHookEvent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class IfElseActionComponent extends ActionComponent
	{
		public function IfElseActionComponent()
		{
			super();
			
			width = 150;
			
			upHookComponent = new UpHookComponent();
			upHookComponent.x = 15;
			
			downHookComponent = new DownHookComponent();
			downHookComponent.x = 15;
			downHookComponent.addEventListener(ActionHookEvent.MATCH_CHANGED, matchChangedHandler);
			
			downHookComponent2 = new DownHookComponent();
			downHookComponent2.y = 30;
			downHookComponent2.x = 35;
			downHookComponent2.addEventListener(ActionHookEvent.MATCH_CHANGED, matchChangedHandler);
		}
		
		private var labelDisplay:Label;
		
		override protected function createChildren():void {
			super.createChildren();
			
			labelDisplay = new Label();
			labelDisplay.text = "If Else";
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.height = 30;
			addChild(labelDisplay);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			downHookComponent.y = height;
			labelDisplay.width = width;
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			graphics.clear();
			graphics.beginFill(Theme.CONTROL_COLOR);
			
			if(downHookComponent.matchActionHook || downHookComponent2.matchActionHook){
				graphics.lineStyle(2, 0xFFCC33,0.7);
			}
			else{
				graphics.lineStyle(2,0x5FB7E4,0.7);
			}
			graphics.moveTo(0,0);
			graphics.lineTo(upHookComponent.x,0);
			graphics.lineTo(upHookComponent.x,5);
			graphics.lineTo(upHookComponent.x+10,5);
			graphics.lineTo(upHookComponent.x+10,0);
			graphics.lineTo(width-15,0);
			
			graphics.curveTo(width,2,width,15);
			graphics.curveTo(width,30,width-16,30);
			
			graphics.lineTo(width-15,30);
			graphics.lineTo(downHookComponent2.x+10,30);
			graphics.lineTo(downHookComponent2.x+10,35);
			graphics.lineTo(downHookComponent2.x,35);
			graphics.lineTo(downHookComponent2.x,30);
			graphics.lineTo(downHookComponent2.x - 15, 30);
			graphics.lineTo(downHookComponent2.x - 15, height-30);
			
			graphics.lineTo(downHookComponent2.x, height-30);
			graphics.lineTo(downHookComponent2.x, height-25);
			graphics.lineTo(downHookComponent2.x+10, height-25);
			graphics.lineTo(downHookComponent2.x+10, height-30);
			graphics.lineTo(width-50, height-30);
			
			graphics.curveTo(width-36,height-28,width-36,height-15);
			graphics.curveTo(width-36,height,width-50,height);
			
			graphics.lineTo(width-50,height);
			graphics.lineTo(downHookComponent.x+10,height);
			graphics.lineTo(downHookComponent.x+10,height+5);
			graphics.lineTo(downHookComponent.x,height+5);
			graphics.lineTo(downHookComponent.x,height);
			graphics.lineTo(0,height);
			graphics.lineTo(0,0);
			graphics.endFill();
			
//			graphics.clear();
//			graphics.beginFill(Theme.CONTROL_COLOR);
//			graphics.drawRect(upHookComponent.x,upHookComponent.y,10,5);
//			graphics.drawRoundRectComplex(0,0,width,30,0,15,0,15);
//			graphics.endFill();
//			
//			graphics.beginFill(Theme.CONTROL_COLOR);
//			graphics.drawRect(downHookComponent2.x,height-30,10,5);
//			graphics.drawRoundRectComplex(0, height - 30, width-36, 30,0,15,0,15);
//			graphics.endFill();
//			
//			graphics.beginFill(downHookComponent.matchActionHook ? Theme.MATCHED_COLOR : Theme.CONTROL_COLOR);
//			graphics.drawRect(downHookComponent.x,height,10,5);
//			graphics.endFill();
//			
//			graphics.beginFill(Theme.CONTROL_COLOR);
//			graphics.drawRect(0, 30, downHookComponent2.x - 15, height - 60);
//			graphics.endFill();
//			
//			graphics.beginFill(downHookComponent2.matchActionHook ? Theme.MATCHED_COLOR : Theme.CONTROL_COLOR);
//			graphics.drawRect(downHookComponent2.x, downHookComponent2.y, 10, 5);
//			graphics.endFill();
		}
		
		private var downHookHeight:Number = 0;
		
		override protected function measure():void{
			if(downHookComponent2.targetHookComponent){
				downHookHeight = 0;
				sumDownHook2Height(downHookComponent2.targetHookComponent.actionComponent);
				measuredHeight = downHookHeight + 60;
			}
			else{
				measuredHeight = 100;
			}
		}
		
		private function sumDownHook2Height(hookComponent:ActionComponent):void
		{
			downHookHeight = downHookHeight + hookComponent.height;
			
			if (hookComponent.downHookComponent && hookComponent.downHookComponent.targetHookComponent)
				sumDownHook2Height(hookComponent.downHookComponent.targetHookComponent.actionComponent);
		}
			
			
	}
}
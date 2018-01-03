package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.DoWhileAction;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.event.ActionHookEvent;
	import com.xiaomu.util.Theme;
	
	import coco.component.Label;
	
	public class DoWhileActionComponent extends ActionComponent
	{
		public function DoWhileActionComponent()
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
			
			actionClass = DoWhileAction;
		}
		
		private var labelDisplay:Label;
						
		override protected function createChildren():void {
			super.createChildren();
							
			labelDisplay = new Label();
			labelDisplay.color = 0xFFFFFF;
			labelDisplay.text = "Do While";
			labelDisplay.height = 30;
			addChild(labelDisplay);
		}
							
		override protected function measure():void {
			if (downHookComponent2.targetHookComponent)
					{
						downHookHeight = 0;
						sumDownHook2Height(downHookComponent2.targetHookComponent.actionComponent);
						measuredHeight = downHookHeight + 60;
					}
				else
					{
						 measuredHeight = 120;
					}
			}
						
		override protected function updateDisplayList():void {
				super.updateDisplayList();
									
				downHookComponent.y = height;
								
				labelDisplay.width = width;
		 }
							
			override protected function drawSkin():void
			{			
				graphics.clear();
				graphics.beginFill(Theme.CONTROL_COLOR);
				graphics.drawRect(upHookComponent.x, upHookComponent.y, 10, 5);
				graphics.drawRoundRectComplex(0, 0, width, 30,0,15,0,15);
				graphics.endFill();
									
				graphics.beginFill(Theme.CONTROL_COLOR);
				graphics.drawRect(downHookComponent2.x, height - 30, 10, 5);
				graphics.drawRoundRectComplex(0, height - 30, width-36, 30,0,15,0,15);
				graphics.endFill();
									
				graphics.beginFill(downHookComponent.matchActionHook ? 0x00FF00 : 0x81CBFA);
				graphics.drawRect(downHookComponent.x, height, 10, 5);
				graphics.endFill();
								
				graphics.beginFill(Theme.CONTROL_COLOR);
				graphics.drawRect(0, 30, downHookComponent2.x - 15, height - 60);
				graphics.endFill();
									
				graphics.beginFill(downHookComponent2.matchActionHook ? Theme.MATCHED_COLOR : Theme.CONTROL_COLOR);
				graphics.drawRect(downHookComponent2.x, downHookComponent2.y, 10, 5);
				graphics.endFill();
		}
							
		override protected function matchChangedHandler(event:ActionHookEvent):void
		{
				invalidateSkin();
		}
								
		private var downHookHeight:Number = 0;
						
		private function sumDownHook2Height(hookComponent:ActionComponent):void
		{
				downHookHeight = downHookHeight + hookComponent.height;
									
				if (hookComponent.downHookComponent && hookComponent.downHookComponent.targetHookComponent)
				sumDownHook2Height(hookComponent.downHookComponent.targetHookComponent.actionComponent);
		 }
								
		}
	}

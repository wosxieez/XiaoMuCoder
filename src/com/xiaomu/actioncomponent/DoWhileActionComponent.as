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
						 measuredHeight = 100;
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
				
				if(downHookComponent.matchActionHook || downHookComponent2.matchActionHook){
					graphics.lineStyle(2, 0xFFCC33,0.7);
				}
				else{
					graphics.lineStyle(2,0x5FB7E4,0.7);
				}
				graphics.moveTo(0,0);
				graphics.lineTo(upHookComponent.x-3,0);
				graphics.lineTo(upHookComponent.x,6);
				graphics.lineTo(upHookComponent.x+7,6);
				graphics.lineTo(upHookComponent.x+10,0);
				graphics.lineTo(width-15,0);
				
				graphics.curveTo(width,2,width,15);
				graphics.curveTo(width,30,width-16,30);
				
				graphics.lineTo(width-15,30);
				graphics.lineTo(downHookComponent2.x+10,30);
				graphics.lineTo(downHookComponent2.x+7,36);
				graphics.lineTo(downHookComponent2.x,36);
				graphics.lineTo(downHookComponent2.x-3,30);
				graphics.lineTo(downHookComponent2.x - 15, 30);
				graphics.lineTo(downHookComponent2.x - 15, height-30);
				
				graphics.lineTo(downHookComponent2.x-3, height-30);
				graphics.lineTo(downHookComponent2.x, height-24);
				graphics.lineTo(downHookComponent2.x+7, height-24);
				graphics.lineTo(downHookComponent2.x+10, height-30);
				graphics.lineTo(width-50, height-30);
				
				graphics.curveTo(width-36,height-28,width-36,height-15);
				graphics.curveTo(width-36,height,width-50,height);
				
				graphics.lineTo(width-50,height);
				graphics.lineTo(downHookComponent.x+10,height);
				graphics.lineTo(downHookComponent.x+7,height+6);
				graphics.lineTo(downHookComponent.x,height+6);
				graphics.lineTo(downHookComponent.x-3,height);
				graphics.lineTo(0,height);
				graphics.lineTo(0,0);
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

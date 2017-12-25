package com.xiaomu.view.actionview
{
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.HookComponent;
	import com.xiaomu.component.UpHookComponent;
	import com.xiaomu.event.ActionHookEvent;
	
	public class TestHookComponent extends ActionComponent
	{
		public function TestHookComponent()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			upHook = new UpHookComponent();
			upHook.hookComponent = this;
			upHook.addEventListener(ActionHookEvent.MATCH_CHANGED, matchedHandler);
			upHook.addEventListener(ActionHookEvent.TARGET_CHANGED, targetChangedHandler);
			
			downHook = new DownHookComponent();
			downHook.hookComponent = this;
			downHook.x = downHook.y = 50;
			downHook.addEventListener(ActionHookEvent.MATCH_CHANGED, matchedHandler);
			downHook.addEventListener(ActionHookEvent.TARGET_CHANGED, targetChangedHandler);
		}
		
		protected function targetChangedHandler(event:ActionHookEvent):void
		{
			invalidateSkin();
		}
		
		protected function matchedHandler(event:ActionHookEvent):void
		{
			invalidateSkin();
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(0x6C6C6C);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
			
			if (upHook)
			{
				graphics.beginFill(upHook.matchHook ? 0x00FF00 : 0xFF0000);
				graphics.drawCircle(upHook.x, upHook.y, 5);
				graphics.endFill();
			}
			
			if (downHook)
			{
				graphics.beginFill(downHook.matchHook ? 0x00FF00 : 0x0000FF);
				graphics.drawCircle(downHook.x, downHook.y, 5);
				graphics.endFill();
			}
			
		}
		
	}
}
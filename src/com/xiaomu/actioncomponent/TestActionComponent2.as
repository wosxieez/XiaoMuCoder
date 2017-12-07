package com.xiaomu.actioncomponent
{
	import com.xiaomu.action.TestAction2;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DropList;
	import com.xiaomu.component.UpFlagHookComponent;
	import com.xiaomu.renderer.SelectboxRender;
	import com.xiaomu.util.Theme;
	
	public class TestActionComponent2 extends ActionComponent
	{
		public function TestActionComponent2()
		{
			super();
			
			width = 50;
			height = 30;
			
			upFlagHookComponent = new UpFlagHookComponent();
		
			actionClass = TestAction2;
		}
		
		private var flagHookComponent1:UpFlagHookComponent;
		
		override protected function createChildren():void
		{
			super.createChildren();

		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(Theme.CONTROL_COLOR);
			graphics.drawRoundRectComplex(0, 0, width, height, 5, 5, 5, 5);
			graphics.endFill();
		}
		
	}
}
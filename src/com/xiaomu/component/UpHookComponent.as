package com.xiaomu.component
{
	public class UpHookComponent extends HookComponent
	{
		public function UpHookComponent()
		{
			super();
		}
		
		override public function match(hook:HookComponent):Boolean
		{
			if (!targetHookComponent && hook is DownHookComponent)
			{
				return super.match(hook);
			}
			else
				return false;
		}
		
	}
}
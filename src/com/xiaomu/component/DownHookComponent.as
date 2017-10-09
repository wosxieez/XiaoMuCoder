package com.xiaomu.component
{
	public class DownHookComponent extends HookComponent
	{
		public function DownHookComponent()
		{
			super();
		}
		
		override public function match(hook:HookComponent):Boolean
		{
			if (hook is UpHookComponent)
				return super.match(hook);
			else
				return false;
		}
		
	}
}
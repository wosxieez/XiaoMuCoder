package com.xiaomu.component
{
	public class DownFlagHookComponent extends FlagHookComponent
	{
		public function DownFlagHookComponent()
		{
			super();
		}
		
		override public function match(hook:HookComponent):Boolean
		{
			if (hook is UpFlagHookComponent)
				return super.match(hook);
			else
				return false;
		}
		
	}
}
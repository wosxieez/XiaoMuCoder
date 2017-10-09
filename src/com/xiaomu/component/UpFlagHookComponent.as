package com.xiaomu.component
{
	public class UpFlagHookComponent extends FlagHookComponent
	{
		public function UpFlagHookComponent()
		{
			super();
		}
		
		override public function match(hook:HookComponent):Boolean
		{
			if (hook is DownFlagHookComponent)
				return super.match(hook);
			else
				return false;
		}
		
	}
}
package com.xiaomu.manager
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="addlogin", type="com.xiaomu.event.LoginEvent")]
	[Event(name="enterApp", type="com.xiaomu.event.LoginEvent")]

	
	public class LoginManager extends EventDispatcher
	{
		public function LoginManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var instance : LoginManager ;
		
		public static function getInstance():LoginManager
		{
			if(!instance)
				instance = new LoginManager();
			
			return instance;
		}
	}
}
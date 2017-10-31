package com.xiaomu.event
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const ADD_LOGIN : String = "addlogin";
		public static const ENTER_APP : String = "enterApp";
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
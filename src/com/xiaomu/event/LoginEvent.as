package com.xiaomu.event
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const ADD_LOGIN : String = "addlogin";
		public static const ENTER_APP : String = "enterApp";
		public static const RETURN_CREATE : String = "returnCreate";
		public static const RETURN_APP : String = "returnApp";
		public static const EDIT_USER : String = "editUser";
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
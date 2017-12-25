package com.xiaomu.event
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		/**
		 * 点击切换账号到登陆界面
		 */	
		public static const ADD_LOGIN : String = "addlogin";
		/**
		 * 首页创作界面点击“进入APP”时派发
		 */
		public static const ENTER_APP : String = "enterApp";
		/**
		 * 在APP界面点击“返回创作”到创作页面时派发
		 */
		public static const RETURN_CREATE : String = "returnCreate";
		/**
		 * 在登陆界面点击“返回APP”时派发，结果返回APP界面
		 */
		public static const RETURN_APP : String = "returnApp";
		public static const EDIT_USER : String = "editUser";
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
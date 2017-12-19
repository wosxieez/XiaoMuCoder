package com.xiaomu.event
{
	import com.xiaomu.data.Role;
	
	import flash.events.Event;
	
	public class RoleEvent extends Event
	{
		public static const ADD_ROLE : String = "addRole"; // 添加角色
		public static const SELECT_ROLE :String = "selectRole" // 选中角色
		public static const REMOVE_ROLE : String = "removeRole"  //  移除角色
		public static const SET_ROLE : String = "setRole" //  设置角色
		
		/**
		 * 新角色 
		 */		
		public var role:Role;
		/**
		 * 旧的选中角色 
		 */		
		public var oldRole:Role;
		
		/*选中的索引*/
		public var index : int;
		
		public function RoleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
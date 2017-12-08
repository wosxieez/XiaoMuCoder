package com.xiaomu.event
{
	import com.xiaomu.data.Role;
	
	import flash.events.Event;
	
	public class RoleEvent extends Event
	{
		public static const ADD_ROLE : String = "addRole";
		public static const SELECT_ROLE :String = "selectRole"
		public static const REMOVE_ROLE : String = "removeRole"
		public static const SET_ROLE : String = "setRole";
		public static const ADD_ROLE_COLLECTION : String= "addRoleCollection";	
		public static const DELETE_ROLESKIN : String = "deleteRoleSkin";
		public static const ADD_ROLESKIN : String = "addRoleSkin";
		public static const SELECT_ITEM : String = "selectItem";
		public static const ADD_BACKGROUND:String = "addBackground";
		public static const ADD_BACKGROUNDMUSIC:String = "addBackgroundMusic";
		public static const REMOVE_BACKGROUND : String = "removeBackground"
		public static const SELECT_BACKGROUND : String = "selectBackground"
		public static const  SELECT_SHOWLIST:String = "selectShowList";
		
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
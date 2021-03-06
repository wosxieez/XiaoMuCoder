package com.xiaomu.manager
{
	import com.xiaomu.data.Role;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.view.stageview.RoleComponent;
	import com.xiaomu.view.stageview.StageView;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import coco.core.coco;
	
	[Event(name="addRole", type="com.xiaomu.event.RoleEvent")]
	[Event(name="addBackground", type="com.xiaomu.event.RoleEvent")]
	[Event(name="addBackgroundMusic", type="com.xiaomu.event.RoleEvent")]
	[Event(name="selectRole", type="com.xiaomu.event.RoleEvent")]
	[Event(name="removeRole", type="com.xiaomu.event.RoleEvent")]
	[Event(name="removeBackground", type="com.xiaomu.event.RoleEvent")]
	[Event(name="setRole", type="com.xiaomu.event.RoleEvent")]
	[Event(name="addRoleCollection", type="com.xiaomu.event.RoleEvent")]
	[Event(name="deleteRoleSkin", type="com.xiaomu.event.RoleEvent")]
	[Event(name="addRoleSkin", type="com.xiaomu.event.RoleEvent")]
	[Event(name="selectRoleSkin", type="com.xiaomu.event.RoleEvent")]
	[Event(name="selectItem", type="com.xiaomu.event.RoleEvent")]
	[Event(name="selectShowList", type="com.xiaomu.event.RoleEvent")]
	[Event(name="addDialog", type="com.xiaomu.event.RoleEvent")]


	public class RoleManager extends EventDispatcher
	{
		
		public function RoleManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Get Instance
		//
		//----------------------------------------------------------------------------------------------------------------
		
		//单例
		private static var instance : RoleManager ;
		
		public static function getInstance():RoleManager
		{
			if(!instance)
				instance = new RoleManager();
			
			return instance;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		/**
		 * 选中的角色 
		 */		
		public var currentRole:Role;
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		/**
		 * 添加一个角色 
		 * @param role
		 */		
		public function addRole(role:Role):void
		{
			var roleEvent:RoleEvent = new RoleEvent(RoleEvent.ADD_ROLE);
			roleEvent.role = role;
			RoleManager.getInstance().dispatchEvent(roleEvent);
		}
		
		/**
		 * 选中一个角色 
		 * @param role
		 */		
		public function selectRole(role:Role):void
		{
			if (role == currentRole) return;
			
			var roleEvent:RoleEvent = new RoleEvent(RoleEvent.SELECT_ROLE);
			roleEvent.oldRole = currentRole;
			currentRole = role;
			roleEvent.role = currentRole;
			RoleManager.getInstance().dispatchEvent(roleEvent);
		}
		
		/**
		 * 删除一个角色 
		 * @param role
		 */		
		public function removeRole(role:Role):void
		{
			// 如果删除的是当前选中的角色 首页取消选中
			selectRole(null);
			
			var roleEvent : RoleEvent = new RoleEvent(RoleEvent.REMOVE_ROLE);
			roleEvent.role = role;
			RoleManager.getInstance().dispatchEvent(roleEvent);
		}
		
		/*设置一个角色*/
		public function setRole(role:Role):void
		{
		    var roleEvent : RoleEvent = new RoleEvent(RoleEvent.SET_ROLE);
			roleEvent.role = role;
			RoleManager.getInstance().dispatchEvent(roleEvent);
		}

		/**
		 * 根据角色数据获取角色组件
		 * @param role
		 * @return 
		 */		
		public function getRoleComponent(role:Role):RoleComponent
		{
			if (!role)
				return null;
			else
				return StageView.getInstance().coco::getRoleComponent(role);
		}
	
		public function addDialog(role:Role):void
		{
			var roleEvent : RoleEvent = new RoleEvent(RoleEvent.ADD_DIALOG);
			roleEvent.role = role;
			RoleManager.getInstance().dispatchEvent(roleEvent);
		}
		
	}
}
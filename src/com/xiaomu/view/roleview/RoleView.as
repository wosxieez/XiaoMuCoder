package com.xiaomu.view.roleview
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.IconButton2;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.RoleManager;
	import com.xiaomu.view.appView.XiaoMuCreate;
	
	import flash.events.MouseEvent;
	
	import coco.component.Group;
	import coco.component.SkinComponent;
	import coco.layout.HorizontalOrderLayout;
	import coco.manager.PopUpManager;
	
	/**
	 * 角色舞台视图 
	 * @author coco
	 */	
	public class RoleView extends SkinComponent
	{
		public function RoleView()
		{
			super();
			
			borderAlpha = backgroundAlpha = 1;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xFEFBF0;
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_ROLE,addRoleHandler);
//			RoleManager.getInstance().addEventListener(RoleEvent.ADD_ROLESKIN,addRoleSkinHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_BACKGROUND,addBgsHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.REMOVE_BACKGROUND,removeBgsHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_ROLE,selectRoleHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_ROLESKIN,selectRoleSkinHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.REMOVE_ROLE,removeRoleHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_ROLE_COLLECTION,addRoleCollectionHandler);
		}	
	
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Get Instance
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private static var instance:RoleView;
		
		public static function getInstance():RoleView
		{
			if (!instance)
				instance = new RoleView();
			
			return instance;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var addRoleButton:IconButton2;
		private var group:Group;
		private var groupbg:Group;
		
		private var _rcollection :RoleCollection;
		
		public function get rcollection():RoleCollection
		{
			if (!_rcollection)
				_rcollection = new RoleCollection();
			
			return _rcollection;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addRoleButton = new IconButton2();
			addRoleButton.source = "assets/fodder.png";
			addRoleButton.addEventListener(MouseEvent.CLICK, addRoleButton_clickHandler);
			addChild(addRoleButton);
			
			var layout:HorizontalOrderLayout = new HorizontalOrderLayout();
			layout.padding = 10;
			layout.gap = 10;
			
			group = new Group();
			group.layout = layout;
			addChild(group);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			group.width =width;
			group.height =height;
			
			addRoleButton.x = width - 5 - addRoleButton.width;
			addRoleButton.y = height - 20 - addRoleButton.height / 2;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.beginFill(0xF9F4E6);
			graphics.drawRect(0, height - 40, width, 40);
			graphics.endFill();
		}
		
		protected function addRoleButton_clickHandler(event:MouseEvent):void
		{
			// 如果角色面板当前已经是打开状态 则不进行任何处理
			if (rcollection.isPopUp) return;
			
			PopUpManager.addPopUp(rcollection, null, true, true, 0, .1);
			PopUpManager.centerPopUp(rcollection);
		}
		
		protected function addRoleHandler(event:RoleEvent):void
		{
			if (event.role&&group.numChildren!=0)
			{
				var roleCover:RoleCover = new RoleCover();
				roleCover.role = event.role;
				group.addChild(roleCover);
			}
			else if(event.role&&group.numChildren==0){
				AppAlert.show("请先选择背景");
			}
		}
		
		protected function selectRoleSkinHandler(event:RoleEvent):void
		{
			group.removeChildAt(selectindex);
			
				var roleCover:RoleCover = new RoleCover();
				roleCover.role = event.role;
				roleCover.name = event.role.name;
				roleCover.role.icon = event.role.source;
			group.addChildAt(roleCover,selectindex);
			
			// TODO Auto-generated method stub
			
		}	
		
		
//		protected function addRoleSkinHandler(event:RoleEvent):void
//		{
//			group.removeChildAt(selectindex);
//			
//			var roleCover:RoleCover = new RoleCover();
//			roleCover.role = event.role;
//			roleCover.name = event.role.name;
//			roleCover.role.icon = event.role.source;
//			group.addChildAt(roleCover,selectindex);
//		}
		
		protected function addBgsHandler(event:RoleEvent):void
		{
			if (event.role)
			{
				var roleCover:RoleCover = new RoleCover();
				roleCover.role = event.role;
				
				if(group.numChildren == 0){
					group.addChild(roleCover);
					trace(event.role.isBackground);
				}
				else{
					group.removeChildAt(0);
					group.addChild(roleCover);
					trace(event.role.isBackground);
				}
			}
		}
		
		private var selectindex:int;
		protected function selectRoleHandler(event:RoleEvent):void
		{
			var selectedRoleId:String = event.role ? event.role.id : "none";
			
			var roleCover:RoleCover;
			for (var i:int = 0; i < group.numChildren; i++)
			{
				roleCover = group.getChildAt(i) as RoleCover;
				if (roleCover)
				{
					if (roleCover.role.id == selectedRoleId)
					{
						roleCover.selected = true;
						selectindex = i;
					}
					else
					{
						roleCover.selected = false;
					}
				}
			}
		}	
		
		
		
		
		protected function removeRoleHandler(event:RoleEvent):void
		{
			var roleCover : RoleCover;
			for (var i:int = 0; i < group.numChildren ; i++) 
			{
				roleCover = group.getChildAt(i) as RoleCover ;
				if(roleCover)
				{
					if(roleCover.role.id == event.role.id)
					{
						group.removeChild(roleCover);
					}
				}
			}
		}
		
		protected function removeBgsHandler(event:RoleEvent):void
		{
			var roleCover : RoleCover;
			for (var i:int = 0; i < group.numChildren ; i++) 
			{
				roleCover = group.getChildAt(i) as RoleCover ;
				if(roleCover)
				{
					if(roleCover.role.id == event.role.id)
					{
						group.removeChild(roleCover);
					}
				}
			}
		}		
		
		protected function addRoleCollectionHandler(event:RoleEvent):void
		{
			trace("收到了");
			PopUpManager.addPopUp(rcollection, null, true, true, 0, .1);
			PopUpManager.centerPopUp(rcollection);
		}		
		
	}
}
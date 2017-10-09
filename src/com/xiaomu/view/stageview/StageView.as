package com.xiaomu.view.stageview
{
	import com.xiaomu.data.Role;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.ActionComponentManager;
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import coco.component.Button;
	import coco.component.SkinComponent;
	import coco.core.coco;
	
	/**
	 * 舞台视图 
	 * @author coco
	 * 
	 */	
	public class StageView extends SkinComponent
	{
		public function StageView()
		{
			super();
			
			borderAlpha = backgroundAlpha = 1;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xFEFBF0;
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_ROLE,addRoleHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_ROLE,selectRoleHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.REMOVE_ROLE, removeRoleHandler);
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Get Instance
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private static var instance:StageView;
		
		public static function getInstance():StageView
		{
			if (!instance)
				instance = new StageView();
			
			return instance;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var transformer:Transformer;
		private var roleContainer:SkinComponent;
		private var playButton:Button;
		private var aButton:Button;
		private var bButton:Button;
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			roleContainer = new SkinComponent();
			roleContainer.backgroundAlpha = roleContainer.borderAlpha = 0;
			roleContainer.addEventListener(MouseEvent.MOUSE_DOWN, roleContainer_mouseDownHandler);
			addChild(roleContainer);
			
			transformer = new Transformer();
			roleContainer.addChild(transformer);
			
			playButton = new Button();
			playButton.label = "播放";
			playButton.addEventListener(MouseEvent.CLICK, playButton_clickHandler);
			addChild(playButton);
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			roleContainer.width = width;
			roleContainer.height = height - 30;
			roleContainer.scrollRect = new Rectangle(0, 0, roleContainer.width, roleContainer.height);
			playButton.y = height - 30;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.beginFill(0xF9F4E6);
			graphics.drawRect(0, height - 30, width, 30);
			graphics.endFill();
		}
		
		protected function addRoleHandler(event:RoleEvent):void
		{
			var roleComponent:RoleComponent = new RoleComponent();
			roleComponent.role = event.role;
			roleComponent.x = (roleContainer.width - roleComponent.width) / 2;
			roleComponent.y = (roleContainer.height - roleComponent.height) / 2;
			roleContainer.addChild(roleComponent);
		}	
		
		protected function removeRoleHandler(event:RoleEvent):void
		{
			var roleComponent:RoleComponent;
			for (var i:int = 0; i < roleContainer.numChildren; i++)
			{
				roleComponent = roleContainer.getChildAt(i) as RoleComponent;
				if (roleComponent && roleComponent.role.id == event.role.id)
				{
					roleContainer.removeChild(roleComponent);
					break;
				}
			}
		}	
		
		protected function selectRoleHandler(event:RoleEvent):void
		{
			if (event.role)
			{
				var roleComponent:RoleComponent;
				for (var i:int = 0; i < roleContainer.numChildren; i++)
				{
					roleComponent = roleContainer.getChildAt(i) as RoleComponent;
					if (roleComponent && roleComponent.role.id == event.role.id)
					{
						transformer.target = roleComponent;
						return;
					}
				}
			}
			
			transformer.target = null;
		}
		
		/**
		 * 根据角色数据获取角色组件 
		 * Use RoleManager.getInstance().getRoleComponent() instead of
		 * @param role
		 * @return      
		 */		
		coco function getRoleComponent(role:Role):RoleComponent
		{
			var roleComponent:RoleComponent;
			for (var i:int = 0; i < roleContainer.numChildren; i++)
			{
				roleComponent = roleContainer.getChildAt(i) as RoleComponent;
				if (roleComponent && roleComponent.role.id == role.id)
				{
					return roleComponent;
				}
			}
			
			return null;
		}
		
		protected function roleContainer_mouseDownHandler(event:MouseEvent):void
		{
			if (event.target is RoleComponent)
			{
				RoleManager.getInstance().selectRole((event.target as RoleComponent).role);
				
				transformer.target = event.target as RoleComponent;
				transformer.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
			else if (event.target is Transformer)
			{
				// do things
			}
			else
			{
				transformer.target = null; 
			}
		}
		
		protected function playButton_clickHandler(event:MouseEvent):void
		{
			// 取消变形操作
			transformer.target = null;
			
			// 保存当前的脚本数据 到 当前选中的角色
			ActionComponentManager.getInstance().actionComponentsToActions(
				RoleManager.getInstance().getRoleComponent(RoleManager.getInstance().currentRole));
			
			// 开始执行脚本动作
			var roleComponent:RoleComponent;
			for (var i:int = 0; i < roleContainer.numChildren; i++)
			{
				roleComponent = roleContainer.getChildAt(i) as RoleComponent;
				if (roleComponent)
					roleComponent.doAction();
			}
		}
		
	}
}
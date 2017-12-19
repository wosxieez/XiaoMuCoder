package com.xiaomu.view.stageview {
	import com.xiaomu.component.PlayButton;
	import com.xiaomu.data.Role;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.ActionComponentManager;
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.Event;
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
	public class StageView extends SkinComponent {
		public function StageView() {
			super();
			
			borderAlpha = backgroundAlpha = 1;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xFEFBF0;
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_ROLE, addRoleHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_ROLE, selectRoleHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.REMOVE_ROLE, removeRoleHandler);
		}
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Get Instance
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private static var instance:StageView;
		
		public static function getInstance():StageView {
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
		private var playButton:PlayButton;
		private var aButton:Button;
		private var bButton:Button;
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void {
			super.createChildren();
			
			roleContainer = new SkinComponent();
			roleContainer.backgroundAlpha = roleContainer.borderAlpha = 0;
			roleContainer.addEventListener(MouseEvent.MOUSE_DOWN, roleContainer_mouseDownHandler);
			addChild(roleContainer);
			
			transformer = new Transformer();
			roleContainer.addChild(transformer);
			
			playButton = new PlayButton();
			playButton.text = "开始";
			playButton.selectedSource = "assets/stop1.png";
			playButton.selectedText = "结束";
			playButton.source = "assets/begin1.png";
			playButton.addEventListener(MouseEvent.CLICK, playButton_clickHandler);
			addChild(playButton);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			roleContainer.width = width;
			roleContainer.height = height - 30;
			roleContainer.scrollRect = new Rectangle(0, 0, roleContainer.width, roleContainer.height);
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			playButton.y = height - 68;
			playButton.x = 7;
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			graphics.beginFill(0xF9F4E6);
			graphics.drawRect(0, height - 70, width, 70);
			graphics.endFill();
		}
		
		protected function addRoleHandler(event:RoleEvent):void {
			// 添加新角色 添加角色的类型有可能是 背景/音乐 在这做处理
			switch (event.role.type) {
				case "bg":
					addBackgroundRole(event.role)
					break;
				case "music":
					addMusicRole(event.role)
				default:
					addNewRole(event.role)
					break;
			}
		}
		
		private function addNewRole(role:Role):void {
			var roleComponent:RoleComponent = new RoleComponent();
			roleComponent.role = role;
			roleComponent.x = (roleContainer.width - roleComponent.width) / 2;
			roleComponent.y = (roleContainer.height - roleComponent.height) / 2;
			roleContainer.addChild(roleComponent);
		}
		
		private function addBackgroundRole(role:Role):void {
			// 删除已经存在的背景角色
			var child:RoleComponent
			for (var index:int = 0; index < roleContainer.numChildren; index++) {
				child = roleContainer.getChildAt(index) as RoleComponent
				if (child && child.role.type == "bg") {
					roleContainer.removeChild(child)
				}
			}
			
			// 添加背景角色到第一个位置
			var bgRoleComponent:RoleComponent = new RoleComponent()
			bgRoleComponent.width = roleContainer.width
			bgRoleComponent.height = roleContainer.height
			bgRoleComponent.role = role
			bgRoleComponent.mouseEnabled = false
			roleContainer.addChildAt(bgRoleComponent, 0)
		}
		
		private function addMusicRole(role:Role):void {
		
		}
		
		private var roleComponent_bg:RoleComponent;
		private var roleComponent_bg1:RoleComponent;
		
		protected function removeRoleHandler(event:RoleEvent):void {
			var roleComponent:RoleComponent;
			for (var i:int = 0; i < roleContainer.numChildren; i++) {
				roleComponent = roleContainer.getChildAt(i) as RoleComponent;
				if (roleComponent && roleComponent.role.id == event.role.id) {
					roleContainer.removeChild(roleComponent);
					break;
				}
			}
		}
		
		protected function selectRoleHandler(event:RoleEvent):void {
			
			if (event.role) {
				var roleComponent:RoleComponent;
				
				for (var i:int = 0; i < roleContainer.numChildren; i++) {
					roleComponent = roleContainer.getChildAt(i) as RoleComponent;
					
					if (roleComponent && roleComponent.role.id == event.role.id) {
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
		coco function getRoleComponent(role:Role):RoleComponent {
			var roleComponent:RoleComponent;
			for (var i:int = 0; i < roleContainer.numChildren; i++) {
				roleComponent = roleContainer.getChildAt(i) as RoleComponent;
				if (roleComponent && roleComponent.role.id == role.id) {
					return roleComponent;
				}
			}
			
			return null;
		}
		
		protected function roleContainer_mouseDownHandler(event:MouseEvent):void {
			if (event.target is RoleComponent) {
				RoleManager.getInstance().selectRole((event.target as RoleComponent).role);
				
				transformer.target = event.target as RoleComponent;
				transformer.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
			else if (event.target is Transformer) {
				// do things
			}
			else {
				transformer.target = null;
			}
		}
		
		protected function playButton_clickHandler(event:MouseEvent):void {
			playButton.selected = !playButton.selected;
			// 取消变形操作
			transformer.target = null;
			
			// 保存当前的脚本数据 到 当前选中的角色
			ActionComponentManager.getInstance().actionComponentsToActions(
					RoleManager.getInstance().getRoleComponent(RoleManager.getInstance().currentRole));
			
			// 开始执行脚本动作
			var roleComponent:RoleComponent;
			for (var i:int = 0; i < roleContainer.numChildren; i++) {
				roleComponent = roleContainer.getChildAt(i) as RoleComponent;
				if (roleComponent && playButton.selected == true)
					roleComponent.doAction();
			}
			
			if (roleComponent_bg) {
				if (playButton.selected) {
					roleComponent_bg.addEventListener(Event.ENTER_FRAME, enter_frameHandle);
					roleComponent_bg1.addEventListener(Event.ENTER_FRAME, enter_frameHandle);
				}
				else {
					roleComponent_bg.removeEventListener(Event.ENTER_FRAME, enter_frameHandle);
					roleComponent_bg1.removeEventListener(Event.ENTER_FRAME, enter_frameHandle);
				}
			}
		}
		
		protected function enter_frameHandle(event:Event):void {
			roleComponent_bg.x -= 1;
			roleComponent_bg1.x -= 1;
			if (roleComponent_bg1.x <= 0) {
				//				roleComponent_bg.removeEventListener(Event.ENTER_FRAME,enter_frameHandle);
				roleComponent_bg.x = 0;
				roleComponent_bg1.x = roleComponent_bg.width;
			}
		}
		
	}
}
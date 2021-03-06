package com.xiaomu.manager
{
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.DownFlagHookComponent;
	import com.xiaomu.component.DownHookComponent;
	import com.xiaomu.component.HookComponent;
	import com.xiaomu.data.Action;
	import com.xiaomu.data.Hook;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	
	import coco.core.Application;
	import coco.core.UIComponent;
	import coco.core.coco;
	
	/**
	 * 脚本组件管理器 
	 * @author coco
	 * 
	 */	
	public class ActionComponentManager
	{
		public function ActionComponentManager()
		{
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_ROLE, roleManager_selectHandler);
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var view:UIComponent;
		private var draggingActionComponents:Vector.<ActionComponent> = new Vector.<ActionComponent>();
		private var draggingFreeHooks:Vector.<HookComponent> = new Vector.<HookComponent>();
		private var matchingFreeHooks:Vector.<HookComponent> = new Vector.<HookComponent>();
		private var mouseDownX:Number = 0;
		private var mouseDownY:Number = 0;
		private var matchedDraggingHook:HookComponent;
		private var matchedMatchingHook:HookComponent;
		private var useFlagMode:Boolean;  // 使用标记钩子模式
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Get Instance
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private static var instance:ActionComponentManager;
		
		public static function getInstance():ActionComponentManager
		{
			if (!instance)
				instance = new ActionComponentManager();
			
			return instance;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		public function init(viewport:UIComponent):void
		{
			view = viewport;
			view.addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler);
		}
		
		protected function this_mouseDownHandler(event:MouseEvent):void
		{
			Application.topApplication.applicationFPS = 5; // 降低帧频率
			
			doDraggingActionComponent(event.target as ActionComponent);
		}
		
		/**
		 * 开始拖拽一个脚本组件
		 * @param draggingActionComponent
		 */		
		public function doDraggingActionComponent(draggingActionComponent:ActionComponent):void
		{
			if (!draggingActionComponent) return;
			
			// 记录当前鼠标按下的点
			mouseDownX = view.stage.mouseX;
			mouseDownY = view.stage.mouseY;
			
			if (draggingActionComponent.upHookComponent ||
				draggingActionComponent.downHookComponent ||
				draggingActionComponent.downHookComponent2)
			{
				// 匹配上下钩子模式
				useFlagMode = false;
				
				// 解锁向上的钩子
				if (draggingActionComponent.upHookComponent && draggingActionComponent.upHookComponent.targetHookComponent)
				{
					draggingActionComponent.upHookComponent.targetHookComponent.targetHookComponent = null;
					draggingActionComponent.upHookComponent.targetHookComponent = null;
				}
				
				trace("匹配上下钩子模式");
			}
			else
			{
				// 匹配标记钩子模式
				useFlagMode = true;
				
				// 解锁向上的标记钩子
				if (draggingActionComponent.upFlagHookComponent && draggingActionComponent.upFlagHookComponent.targetHookComponent)
				{
					draggingActionComponent.upFlagHookComponent.targetHookComponent.targetHookComponent = null;
					draggingActionComponent.upFlagHookComponent.targetHookComponent = null;
				}
				
				trace("匹配标记钩子模式");
			}
			
			initDraggingActionComponents(draggingActionComponent); // 生成所有的拖拽脚本组件
			initDraggingFreeHooks(draggingActionComponent); // 生成空闲可匹配的钩子组
			initMatchingFreetHooks(); // 生成匹配目标的钩子组
			
			view.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			view.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		
		protected function stage_mouseMoveHandler(event:MouseEvent):void
		{
			for each (var draggingActionComponent:ActionComponent in draggingActionComponents)
			{
				draggingActionComponent.x = view.stage.mouseX - mouseDownX + draggingActionComponent.mouseDownX;
				draggingActionComponent.y = view.stage.mouseY - mouseDownY + draggingActionComponent.mouseDownY;
			}
			
			event.updateAfterEvent();
			invalidateMatchHook();
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void
		{
			Application.topApplication.applicationFPS = 24; // 恢复帧频率
			
			view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			view.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			
			// 如果有匹配上的钩子 则进行对接
			if (matchedDraggingHook && matchedMatchingHook)
			{
				// 如果匹配目标是向下的钩子且已经有对接的钩子 则属于插入操作
				if (matchedMatchingHook is DownHookComponent && matchedMatchingHook.targetHookComponent)
				{
					var upHook:HookComponent = matchedMatchingHook.targetHookComponent;
					matchedDraggingHook.targetHookComponent = matchedMatchingHook;
					matchedMatchingHook.targetHookComponent = matchedDraggingHook;
					var lastDownHook:DownHookComponent = getLastDownHook(matchedDraggingHook.actionComponent);
					if (lastDownHook)
					{
						lastDownHook.targetHookComponent = upHook;
						upHook.targetHookComponent = lastDownHook;
					}
				}
				else
				{
					matchedDraggingHook.targetHookComponent = matchedMatchingHook;
					matchedMatchingHook.targetHookComponent = matchedDraggingHook;
				}
				
				// 将拖拽的钩子组件移动到缝合的位置
				var targetPoint:Point = matchedMatchingHook.actionComponent.localToGlobal(new Point(0, 0));
				targetPoint.x = targetPoint.x + matchedMatchingHook.x - matchedDraggingHook.x - 
					matchedDraggingHook.actionComponent.mouseDownX + mouseDownX;
				targetPoint.y = targetPoint.y + matchedMatchingHook.y - matchedDraggingHook.y - 
					matchedDraggingHook.actionComponent.mouseDownY + mouseDownY;
				
				for each (var draggingActionComponent:ActionComponent in draggingActionComponents)
				{
					draggingActionComponent.x = targetPoint.x - mouseDownX + draggingActionComponent.mouseDownX;
					draggingActionComponent.y = targetPoint.y - mouseDownY + draggingActionComponent.mouseDownY;
				}
			}
			
			disposeDraggingActionComponents();
			disposeDraggingFreeHooks();
			disposeMatchingFreeHooks();
			disposeMatchedHook();
			updateActionComponentsSize();  // 更新所有钩子组件大小
			updateActionComponentsPosition(); // 更新所有钩子组件位置
		}
		
		private function initDraggingActionComponents(draggingActionComponent:ActionComponent):void
		{
			// 添加到全局视图 能够全局拖拽
			var globalPoint:Point = draggingActionComponent.localToGlobal(new Point(0, 0));
			draggingActionComponent.x = globalPoint.x;
			draggingActionComponent.y = globalPoint.y;
			Application.topApplication.addChild(draggingActionComponent);
			
			draggingActionComponent.mouseDownX = draggingActionComponent.x;
			draggingActionComponent.mouseDownY = draggingActionComponent.y;
			draggingActionComponents.push(draggingActionComponent);
			
			if (draggingActionComponent.downHookComponent && draggingActionComponent.downHookComponent.targetHookComponent)
				initDraggingActionComponents(draggingActionComponent.downHookComponent.targetHookComponent.actionComponent);
			
			if (draggingActionComponent.downHookComponent2 && draggingActionComponent.downHookComponent2.targetHookComponent)
				initDraggingActionComponents(draggingActionComponent.downHookComponent2.targetHookComponent.actionComponent);
			
			for each(var downFlagHookComponent:DownFlagHookComponent in draggingActionComponent.downFlagHookComponents)
			{
				if (downFlagHookComponent && downFlagHookComponent.targetHookComponent)
					initDraggingActionComponents(downFlagHookComponent.targetHookComponent.actionComponent);
			}
		}
		
		private function disposeDraggingActionComponents():void
		{
			var draggingActionComponent:ActionComponent;
			var localPoint:Point;
			while (draggingActionComponents.length > 0)
			{
				draggingActionComponent = draggingActionComponents.shift();
				
				// 还原到脚本视图上
				localPoint = view.globalToLocal(new Point(draggingActionComponent.x, draggingActionComponent.y));
				draggingActionComponent.x = localPoint.x;
				draggingActionComponent.y = localPoint.y;
				view.addChild(draggingActionComponent);
			}
		}
		
		private function initDraggingFreeHooks(draggingActionComponent:ActionComponent):void
		{
			if (useFlagMode)
			{
				// 匹配标记钩子模式
				if (draggingActionComponent.upFlagHookComponent && !draggingActionComponent.upFlagHookComponent.targetHookComponent)
					draggingFreeHooks.push(draggingActionComponent.upFlagHookComponent);
			}
			else
			{
				// 匹配上下钩子模式
				if (draggingActionComponent.upHookComponent && !draggingActionComponent.upHookComponent.targetHookComponent)
					draggingFreeHooks.push(draggingActionComponent.upHookComponent);
				
				if (draggingActionComponent.downHookComponent)
				{
					if (draggingActionComponent.downHookComponent.targetHookComponent)
						initDraggingFreeHooks(draggingActionComponent.downHookComponent.targetHookComponent.actionComponent);
					else
						draggingFreeHooks.push(draggingActionComponent.downHookComponent);
				}
				
				if (draggingActionComponent.downHookComponent2)
				{
					if (!draggingActionComponent.downHookComponent2.targetHookComponent)
						draggingFreeHooks.push(draggingActionComponent.downHookComponent2);
				}
			}
			
			trace("拖拽的钩子", draggingFreeHooks);
		}
		
		private function disposeDraggingFreeHooks():void
		{
			var draggingFreeHook:HookComponent;
			while ( draggingFreeHooks.length > 0)
			{
				draggingFreeHook = draggingFreeHooks.pop();
			}
		}
		
		private function initMatchingFreetHooks():void
		{
			var numActionComponent:int = view.numChildren;
			var childActionComponent:ActionComponent;
			for (var index:int = 0; index < numActionComponent; index++)
			{
				childActionComponent = view.getChildAt(index) as ActionComponent;
				if (childActionComponent)
				{
					if (useFlagMode)
					{
						// 匹配标记钩子模式
						for each(var downFlagHookComponent:DownFlagHookComponent in childActionComponent.downFlagHookComponents)
						{
							if (!downFlagHookComponent.targetHookComponent)
								matchingFreeHooks.push(downFlagHookComponent);
						}
					}
					else
					{
						// 匹配上下钩子模式
						if (childActionComponent.upHookComponent)
							matchingFreeHooks.push(childActionComponent.upHookComponent);
						
						if (childActionComponent.downHookComponent)
							matchingFreeHooks.push(childActionComponent.downHookComponent);
						
						if (childActionComponent.downHookComponent2)
							matchingFreeHooks.push(childActionComponent.downHookComponent2);
					}
				}
			}
			
			trace("匹配的钩子", matchingFreeHooks);
		}
		
		private function disposeMatchingFreeHooks():void
		{
			var matchingFreeHook:HookComponent;
			while ( matchingFreeHooks.length > 0)
			{
				matchingFreeHook = matchingFreeHooks.pop();
			}
		}
		
		private function initMatchedHook(draggingHook:HookComponent, matchingHook:HookComponent):void
		{
			if (draggingHook != matchedDraggingHook ||
				matchingHook != matchedMatchingHook)
			{
				disposeMatchedHook();
				
				matchedDraggingHook = draggingHook;
				matchedMatchingHook = matchingHook;
				
				matchedDraggingHook.matchActionHook = matchedMatchingHook;
				matchedMatchingHook.matchActionHook = matchedDraggingHook;
			}
		}
		
		private function disposeMatchedHook():void
		{
			if (matchedDraggingHook)
			{
				matchedDraggingHook.matchActionHook = null;
				matchedDraggingHook = null;
			}
			if (matchedMatchingHook)
			{
				matchedMatchingHook.matchActionHook = null;
				matchedMatchingHook = null;
			}
		}
		
		private function getLastDownHook(actionComponent:ActionComponent):DownHookComponent
		{
			if (actionComponent.downHookComponent)
			{
				if (actionComponent.downHookComponent.targetHookComponent)
					return getLastDownHook(actionComponent.downHookComponent.targetHookComponent.actionComponent);
				else
					return actionComponent.downHookComponent;
			}
			else
				return null;
		}
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// 布局钩子组件
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private function updateActionComponentsSize():void
		{
			var numActionComponent:int = view.numChildren;
			var childActionComponent:ActionComponent;
			for (var index:int = 0; index < numActionComponent; index++)
			{
				childActionComponent = view.getChildAt(index) as ActionComponent;
				if (childActionComponent)
				{
					if (!childActionComponent.upHookComponent ||
						!childActionComponent.upHookComponent.targetHookComponent)
						updateActionComponentSize(childActionComponent);
				}
			}
		}
		
		private function updateActionComponentSize(actionComponent:ActionComponent):void
		{
			if (actionComponent.downHookComponent && actionComponent.downHookComponent.targetHookComponent)
				updateActionComponentSize(actionComponent.downHookComponent.targetHookComponent.actionComponent);
			
			if (actionComponent.downHookComponent2 && actionComponent.downHookComponent2.targetHookComponent)
				updateActionComponentSize(actionComponent.downHookComponent2.targetHookComponent.actionComponent);
			
			actionComponent.invalidateSize();
			actionComponent.invalidateDisplayList();
		}
		
		private function updateActionComponentsPosition():void
		{
			var numActionComponent:int = view.numChildren;
			var childActionComponent:ActionComponent;
			for (var index:int = 0; index < numActionComponent; index++)
			{
				childActionComponent = view.getChildAt(index) as ActionComponent;
				if (childActionComponent)
				{
					if (!childActionComponent.upHookComponent ||
						!childActionComponent.upHookComponent.targetHookComponent)
						updateActionComponentPosition(childActionComponent);
				}
			}
		}
		
		private function updateActionComponentPosition(actionComponent:ActionComponent):void
		{
			actionComponent.invalidatePosition();
			
			if (actionComponent.downHookComponent && actionComponent.downHookComponent.targetHookComponent)
				updateActionComponentPosition(actionComponent.downHookComponent.targetHookComponent.actionComponent);
			
			if (actionComponent.downHookComponent2 && actionComponent.downHookComponent2.targetHookComponent)
				updateActionComponentPosition(actionComponent.downHookComponent2.targetHookComponent.actionComponent);
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// 钩子匹配失效
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var invalidateMatchHookFlag:Boolean = false; // 属性失效
		
		private function invalidateMatchHook():void
		{
			if (!invalidateMatchHookFlag)
			{
				invalidateMatchHookFlag = true;
				Application.topApplication.callLater(validateMatchHook);
			}
		}
		
		/**
		 * call validateMatchHook now
		 */        
		private function validateMatchHook():void
		{
			if (invalidateMatchHookFlag)
			{
				invalidateMatchHookFlag = false;
				matchHook();
			}
		}
		
		/**
		 * 匹配钩子
		 */		
		private function matchHook():void
		{
			for each(var draggingFreeHook:HookComponent in draggingFreeHooks)
			{
				for each (var matchingFreeHook:HookComponent in matchingFreeHooks)
				{
					if (matchingFreeHook.match(draggingFreeHook))
					{
						initMatchedHook(draggingFreeHook, matchingFreeHook);
						return;
					}
				}
			}
			
			disposeMatchedHook();
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// 脚本组件数据操作
		//
		//----------------------------------------------------------------------------------------------------------------
		
		/**
		 * 将一个角色组件的: 脚本组件 -> 转换为 -> 脚本数据
		 */		
		public function actionComponentsToActions(roleComponent:RoleComponent):void
		{
			// 第一步 目标的角色组件
			if (!roleComponent) return;
			
			// 第二步 
			// ActionComponent Action 数据同步
			var numActionComponent:int = view.numChildren;
			var childActionComponent:ActionComponent;
			var index:int;
			for (index = 0; index < numActionComponent; index++)
			{
				childActionComponent = view.getChildAt(index) as ActionComponent;
				if (childActionComponent)
					childActionComponent.syncOwnToAction();
			}
			
			// 第三步 清空脚本数据
			roleComponent.actions.splice(0, roleComponent.actions.length);
			
			// 第四步 赋值最新的脚本数据
			for (index = 0; index < numActionComponent; index++)
			{
				childActionComponent = view.getChildAt(index) as ActionComponent;
				if ((!childActionComponent.upHookComponent ||!childActionComponent.upHookComponent.targetHookComponent) &&
					(!childActionComponent.upFlagHookComponent || !childActionComponent.upFlagHookComponent.targetHookComponent))
				{
					roleComponent.actions.push(childActionComponent.action);
					trace("创建了action", childActionComponent.action);
				}
			}
		}
		
		/**
		 * 清空所有脚本组件
		 */		
		public function clearActionComponents():void
		{
			view.removeAllChild();
		}
		
		/**
		 * 将一个角色组件的: 脚本数据 -> 转换为 -> 脚本组件
		 * @param roleComponent
		 */		
		public function actionsToActionComponents(roleComponent:RoleComponent):void
		{
			if (!roleComponent) return;
			
			for each (var action:Action in roleComponent.actions)
			{
				actionToActionComponent(action);
			}
			
			updateActionComponentsSize();  // 更新所有钩子组件大小
			updateActionComponentsPosition(); // 更新所有钩子组件位置
		}
		
		private function actionToActionComponent(action:Action):ActionComponent
		{
			// 生成actionComponent
			var actionComponentClass:Class = getDefinitionByName(action.className) as Class;
			var actionComponent:ActionComponent = new actionComponentClass() as ActionComponent;
			actionComponent.coco::action = action;
			view.addChild(actionComponent); // 确保先添加父组件 再添加子组件
			
			if (action.downHook2 && action.downHook2.targetHook && action.downHook2.targetHook.action)
			{
				// 生成钩子2对接的组件 并 相互关联
				var down2ActionComponent:ActionComponent = actionToActionComponent(action.downHook2.targetHook.action);
				if (actionComponent.downHookComponent2)
					actionComponent.downHookComponent2.targetHookComponent = down2ActionComponent.upHookComponent;
				if (down2ActionComponent.upHookComponent)
					down2ActionComponent.upHookComponent.targetHookComponent = actionComponent.downHookComponent2;
			}
			
			if (action.downHook && action.downHook.targetHook && action.downHook.targetHook.action)
			{
				// 生成钩子1对接的组件 并 相互关联
				var downActionComponent:ActionComponent = actionToActionComponent(action.downHook.targetHook.action);
				if (actionComponent.downHookComponent)
					actionComponent.downHookComponent.targetHookComponent = downActionComponent.upHookComponent;
				if (downActionComponent.upHookComponent)
					downActionComponent.upHookComponent.targetHookComponent = actionComponent.downHookComponent;
			}
			
			// 生成向下的标记钩子对接的组件
			var downFlagHook:Hook;
			for (var index:int = 0; index < action.downFlagHooks.length; index++)
			{
				downFlagHook =  action.downFlagHooks[index];
				if (downFlagHook.targetHook && downFlagHook.targetHook.action)
				{
					var downFlagActionComponent:ActionComponent = actionToActionComponent(downFlagHook.targetHook.action);
					var downFlagHookComponent:DownFlagHookComponent = actionComponent.downFlagHookComponents[index];
					if (downFlagActionComponent.upFlagHookComponent)
					{
						downFlagHookComponent.targetHookComponent = downFlagActionComponent.upFlagHookComponent;
						downFlagActionComponent.upFlagHookComponent.targetHookComponent = downFlagHookComponent;
					}
				}
			}
			
			actionComponent.syncActionToOwn(); // 确保先同步子组件的方法  再同步父组件的方法
			
			return actionComponent;
		}
		
		protected function roleManager_selectHandler(event:RoleEvent):void
		{
			actionComponentsToActions(RoleManager.getInstance().getRoleComponent(event.oldRole)); // 保存旧角色组件的脚本数据
			clearActionComponents(); // 清理脚本组件
			actionsToActionComponents(RoleManager.getInstance().getRoleComponent(event.role)); // 生成新角色组件的脚本组件
		}	
		
	}
}
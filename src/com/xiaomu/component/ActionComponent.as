package com.xiaomu.component
{
	import com.xiaomu.data.Action;
	import com.xiaomu.data.Hook;
	import com.xiaomu.event.ActionHookEvent;
	
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import coco.core.UIComponent;
	import coco.core.coco;
	
	/**
	 * 钩子组件超类 
	 * @author coco
	 */	
	public class ActionComponent extends UIComponent
	{
		
		public function ActionComponent()
		{
			super();
			/**
			 * 
			 * 默认值改成true，支持鼠标输入等
			 */
			mouseChildren = false;
		}
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		public var actionParam:Object;
		public var actionClass:Class;
		public var mouseDownX:Number = 0;
		public var mouseDownY:Number = 0;
		
		private var _menuEnabled:Boolean = true;
		
		public function get menuEnabled():Boolean
		{
			return _menuEnabled;
		}
		
		public function set menuEnabled(value:Boolean):void
		{
			if (_menuEnabled == value) return;
			_menuEnabled = value;
			invalidateProperties();
		}
		
		
		private var _upHookComponent:UpHookComponent;
		
		/**
		 * 向上的钩子 
		 * @return 
		 */		
		public function get upHookComponent():UpHookComponent
		{
			return _upHookComponent;
		}
		
		public function set upHookComponent(value:UpHookComponent):void
		{
			_upHookComponent = value;
			
			if (_upHookComponent)
				_upHookComponent.actionComponent = this;
		}
		
		private var _downHookComponent:DownHookComponent;
		
		/**
		 * 向下的钩子 
		 * @return 
		 */		
		public function get downHookComponent():DownHookComponent
		{
			return _downHookComponent;
		}
		
		public function set downHookComponent(value:DownHookComponent):void
		{
			_downHookComponent = value;
			
			if (_downHookComponent)
			{
				_downHookComponent.actionComponent = this;
				_downHookComponent.addEventListener(ActionHookEvent.MATCH_CHANGED, matchChangedHandler);
			}
		}
		
		private var _downHookComponent2:DownHookComponent;
		
		/**
		 * 向下的钩子2
		 * @return 
		 */		
		public function get downHookComponent2():DownHookComponent
		{
			return _downHookComponent2;
		}
		
		public function set downHookComponent2(value:DownHookComponent):void
		{
			_downHookComponent2 = value;
			
			if (_downHookComponent2)
			{
				_downHookComponent2.actionComponent = this;
				_downHookComponent2.addEventListener(ActionHookEvent.MATCH_CHANGED, matchChangedHandler);
			}
		}
		
		private var _upFlagHookComponent:UpFlagHookComponent;

		/**
		 * 向上的标记钩子 
		 * @return 
		 * 
		 */		
		public function get upFlagHookComponent():UpFlagHookComponent
		{
			return _upFlagHookComponent;
		}

		public function set upFlagHookComponent(value:UpFlagHookComponent):void
		{
			_upFlagHookComponent = value;
			
			if (_upFlagHookComponent)
				_upFlagHookComponent.actionComponent = this;
		}

		
		/**
		 * 向下的标记钩子组
		 * @return 
		 */
		public var downFlagHookComponents:Vector.<DownFlagHookComponent> = new Vector.<DownFlagHookComponent>();
		
		
		private var _action:Action;
		
		/**
		 * action
		 * @return 
		 */
		public function get action():Action
		{
			if (!_action)
				_action = new actionClass() as Action;
			
			return _action;
		}
		
		coco function set action(value:Action):void
		{
			_action = value;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			var menu:ContextMenu = new ContextMenu();
			if (menuEnabled)
			{
				var deleteMenuItem:ContextMenuItem = new ContextMenuItem("删除");
				deleteMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, deleteMenuItem_selectHandler);
				menu.addItem(deleteMenuItem);
			}
			contextMenu = menu;
		}
		
		override protected function measure():void
		{
			measuredWidth = measuredHeight = 50;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			graphics.beginFill(0x6C6C6C);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		/**
		 * 添加一个向下的标记钩子组件
		 * @param flagHookComponent
		 */		
		public function addDownFlagHookComponent(downFlagHookComponent:DownFlagHookComponent):void
		{
			downFlagHookComponent.actionComponent = this;
			downFlagHookComponent.addEventListener(ActionHookEvent.MATCH_CHANGED, matchChangedHandler);
			downFlagHookComponents.push(downFlagHookComponent);
		}
		
		/**
		 * 将属性同步到Action上 
		 */		
		public function syncOwnToAction():void
		{
			action.className = getQualifiedClassName(this);
			action.x = x;
			action.y = y;
			action.actionParam = actionParam;
			
			if (upHookComponent)
			{
				upHookComponent.syncOwnToHook();
				action.upHook = upHookComponent.hook;
			}
			else
				action.upHook = null;
			
			if (downHookComponent)
			{
				downHookComponent.syncOwnToHook();
				action.downHook = downHookComponent.hook;
			}
			else
				action.downHook = null;
			
			if (downHookComponent2)
			{
				downHookComponent2.syncOwnToHook();
				action.downHook2 = downHookComponent2.hook;
			}
			else
				action.downHook2 = null;
			
			if (upFlagHookComponent)
			{
				upFlagHookComponent.syncOwnToHook();
				action.upFlagHook = upFlagHookComponent.hook;
			}
			else
				action.upFlagHook = null;
			
			var downFlagHooks:Vector.<Hook> = new Vector.<Hook>();
			for each (var downFlagHookComponent:FlagHookComponent in downFlagHookComponents)
			{
				downFlagHookComponent.syncOwnToHook();
				downFlagHooks.push(downFlagHookComponent.hook);
			}
			action.downFlagHooks = downFlagHooks;
		}
		
		/**
		 * 将Action的数据同步到属性上
		 */		
		public function syncActionToOwn():void
		{
			x = action.x;
			y = action.y;
			actionParam = action.actionParam;
			actionClass = getDefinitionByName(getQualifiedClassName(this)) as Class;
			
			if (upHookComponent)
			{
				upHookComponent.coco::hook = action.upHook;
				upHookComponent.syncHookToOwn();
			}
			
			if (downHookComponent2)
			{
				downHookComponent2.coco::hook = action.downHook2;
				downHookComponent2.syncHookToOwn();
			}
			
			if (downHookComponent)
			{
				downHookComponent.coco::hook = action.downHook;
				downHookComponent.syncHookToOwn();
			}
		}
		
		protected function deleteMenuItem_selectHandler(event:ContextMenuEvent):void
		{
			// 首先解开钩子
			if (upHookComponent && upHookComponent.targetHookComponent)
			{
				upHookComponent.targetHookComponent.targetHookComponent = null;
				upHookComponent.targetHookComponent = null;
			}
			
			if (downHookComponent2 && downHookComponent2.targetHookComponent)
			{
				downHookComponent2.targetHookComponent.targetHookComponent = null;
				downHookComponent2.targetHookComponent = null;
			}
			
			if (downHookComponent && downHookComponent.targetHookComponent)
			{
				downHookComponent.targetHookComponent.targetHookComponent = null;
				downHookComponent.targetHookComponent = null;
			}
			
			// 删除脚本组件
			parent.removeChild(this);
		}
		
		protected function matchChangedHandler(event:ActionHookEvent):void
		{
			invalidateSkin();
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// 位置失效
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var invalidatePositionFlag:Boolean = false; // 位置失效
		
		public function invalidatePosition():void
		{
			if (!invalidatePositionFlag)
			{
				invalidatePositionFlag = true;
				callLater(validatePosition);
			}
		}
		
		/**
		 * call updatePosition now
		 */        
		public function validatePosition():void
		{
			if (invalidatePositionFlag)
			{
				invalidatePositionFlag = false;
				updatePosition();
			}
		}
		
		/**
		 * 更新相对位置 
		 */		
		protected function updatePosition():void
		{
			if (upHookComponent && upHookComponent.targetHookComponent)
			{
				x = upHookComponent.targetHookComponent.actionComponent.x + upHookComponent.targetHookComponent.x - upHookComponent.x;
				y = upHookComponent.targetHookComponent.actionComponent.y + upHookComponent.targetHookComponent.y - upHookComponent.y;
			}
		}
		
	}
}
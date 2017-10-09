package com.xiaomu.data
{
	import com.xiaomu.view.stageview.RoleComponent;
	
	import coco.core.coco;
	
	/**
	 * 脚本组件数据类 
	 * @author coco
	 */	
	public class Action
	{
		
		/**
		 * x坐标 
		 */		
		public var x:Number;
		/**
		 * y坐标 
		 */		
		public var y:Number;
		/**
		 * 对应的ActionComponent组件类名称 
		 */		
		public var className:String;
		/**
		 * 脚本参数 
		 */		
		public var actionParam:Object;
		/**
		 * 向上的钩子数据 
		 */		
		public var upHook:Hook;
		/**
		 * 向下的钩子数据 
		 */		
		public var downHook:Hook;
		/**
		 * 向下的钩子数据2 
		 */		
		public var downHook2:Hook;
		/**
		 * 向上的标记钩子数据 
		 */		
		public var upFlagHook:Hook;
		/**
		 * 向下的标记钩子数据组 
		 */		
		public var downFlagHooks:Vector.<Hook>;
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Action Control
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var thisActionTarget:RoleComponent;
		private var thisActionCallback:Function;
		
		/**
		 * 执行动作
		 * @param actionTarget
		 * @param actionData
		 * @param actionCallback
		 */		
		coco function doAction(actionTarget:RoleComponent, 
							   actionCallback:Function):void
		{
			thisActionTarget = actionTarget;
			thisActionCallback = actionCallback;
			
			coco::startAction(thisActionTarget, onActionComplete);
		}
		
		private function onActionComplete():void
		{
			// 自己的脚本结束后 执行子脚本
			if (downHook2 && 
				downHook2.targetHook && 
				downHook2.targetHook.action)
			{
				
				downHook2.targetHook.action.coco::doAction(thisActionTarget,
					downActionHook2ActionComplete);
			}
			else if (downHook &&
				downHook.targetHook && 
				downHook.targetHook.action)
			{
				downHook.targetHook.action.coco::doAction(thisActionTarget, 
					downActionHookActionComplete);
			}
			else
			{
				if (thisActionCallback)
					thisActionCallback.call();
			}
		}
		
		private function downActionHook2ActionComplete():void
		{
			if (downHook &&
				downHook.targetHook && 
				downHook.targetHook.action)
			{
				downHook.targetHook.action.coco::startAction(thisActionTarget, 
					downActionHookActionComplete);
			}
			else
			{
				if (thisActionCallback)
					thisActionCallback.call();
			}
		}
		
		private function downActionHookActionComplete():void
		{
			if (thisActionCallback)
				thisActionCallback.call();
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Do Me Action
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var meActionCallback:Function;
		
		coco function startAction(actionTarget:RoleComponent, actionCallback:Function):void
		{
			meActionCallback = actionCallback;
			onAction(actionTarget);
		}
		
		/**
		 * 执行动作 
		 * @param actionTarget
		 * @param actionParam
		 */		
		protected function onAction(actionTarget:RoleComponent):void
		{
			// should override here
			endAction();
		}
		
		/**
		 * 结束动作
		 */		
		protected function  endAction():void
		{
			if (meActionCallback)
				meActionCallback.call();
		}
		
	}
}
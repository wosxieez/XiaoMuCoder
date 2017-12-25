package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	
	public class XandYAction extends Action
	{
		public function XandYAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var animation:Animation = new Animation(actionTarget);
			animation.add("y", 150,actionTarget.y);
			animation.add("x", 150,actionTarget.x);
//			trace(actionTarget.y);
			
			animation.addEventListener(AnimationEvent.COMPLETE, animation_completeHandler);
			animation.start();
		}
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
	}
}
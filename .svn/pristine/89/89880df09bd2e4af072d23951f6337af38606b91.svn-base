package com.xiaomu.action
{
	import com.xiaomu.view.stageview.RoleComponent;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	import com.xiaomu.data.Action;
	
	public class MoveXAction extends Action
	{
		public function MoveXAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var animation:Animation = new Animation(actionTarget);
			animation.add("x", actionTarget.x + 100);
			animation.addEventListener(AnimationEvent.COMPLETE, animation_completeHandler);
			animation.start();
		}
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
		
	}
}
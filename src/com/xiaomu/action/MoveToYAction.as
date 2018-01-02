package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	
	public class MoveToYAction extends Action
	{
		public function MoveToYAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var animation:Animation = new Animation(actionTarget);
			animation.add("y", 200,actionTarget.y);
			animation.addEventListener(AnimationEvent.COMPLETE, animation_completeHandler);
			animation.start();
		}
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
	}
}
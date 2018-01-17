package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	
	public class ShowAfterMomentsAction extends Action
	{
		public function ShowAfterMomentsAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var animation:Animation = new Animation(actionTarget);
			animation.add("alpha", 1,actionTarget.alpha+0.1);
			animation.addEventListener(AnimationEvent.COMPLETE, animation_completeHandler);
			animation.start();
		}
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
	}
}
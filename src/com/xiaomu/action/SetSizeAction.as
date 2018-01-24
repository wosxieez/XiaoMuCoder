package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	
	public class SetSizeAction extends Action
	{
		public function SetSizeAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var animation:Animation = new Animation(actionTarget);
			animation.add("width", (actionTarget.width*80)/100,actionTarget.width);
			animation.add("height", (actionTarget.height*80)/100,actionTarget.height);
			animation.addEventListener(AnimationEvent.COMPLETE, animation_completeHandler);
			animation.start();
		}
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
	}
}
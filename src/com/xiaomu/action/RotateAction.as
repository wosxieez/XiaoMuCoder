package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import flash.display.Stage;
	import flash.geom.Matrix;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	
	public class RotateAction extends Action
	{
		public function RotateAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			
			var animation:Animation = new Animation(actionTarget);
			animation.add("rotation", actionTarget.rotation +90,actionTarget.rotation);
			trace("actionTarget.x"+actionTarget.x);
			trace("actionTarget.y"+actionTarget.y);
//			animation.add("x", actionTarget.x-actionTarget.width/2,actionTarget.x);
			animation.addEventListener(AnimationEvent.COMPLETE, animation_completeHandler);
			animation.start();
		}
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
	}
}
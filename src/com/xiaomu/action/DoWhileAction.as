package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;

	
	public class DoWhileAction extends Action
	{
		public function DoWhileAction()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		protected function animation_completeHandler(event:AnimationEvent):void
		{
			endAction();
		}
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var num:Number = 0;
			var start:int = setInterval(function():void{
				actionTarget.rotation = actionTarget.rotation+30;
				num++;
				if(num>=36){
					clearInterval(start);//test， start只是标志，没有实际意义
					endAction();
				}
			},100);
		}
	}
}
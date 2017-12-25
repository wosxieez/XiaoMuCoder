package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	
	public class Continue extends Action
	{
		public function Continue()
		{
			super();
		}
		
		private var animation:Animation = new Animation();
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			var num:Number = 0;
			var start:int = setInterval(function():void{
				actionTarget.rotation = actionTarget.rotation+30;
				num++;
				if(num>4){
					clearInterval(start);
				}
			},1000);
		}
	}
}
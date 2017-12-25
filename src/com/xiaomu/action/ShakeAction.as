package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import coco.animation.Animation;
	import coco.event.AnimationEvent;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	public class ShakeAction extends Action
	{
		public function ShakeAction()
		{
			super();
		}
		
		private static var isShake:Boolean = false;
		override protected function onAction(actionTarget:RoleComponent):void
		{			
			shake(actionTarget);
		}
			
		protected function shake(dis:DisplayObject,times:uint = 20,offset:uint = 4,speed:uint = 32):void {
			if(isShake) {
				return;
			}
			isShake = true;
			var point:Point = new Point(dis.x,dis.y);
			var offsetXYArray:Array = [0,0];
			var num:int = 0;
			var startShake:int = setInterval(function():void {
				offsetXYArray[num%2] = (num++)%4<2 ?0:offset;
				if(num>(times*4 + 1)){
					clearInterval(startShake);
					num = 0;
					isShake = false;
				}
				dis.x = offsetXYArray[0] + point.x;
				dis.y = offsetXYArray[1] + point.y;
			},speed);
			
			trace("startShake  :"+startShake);
		}
	
	}
}
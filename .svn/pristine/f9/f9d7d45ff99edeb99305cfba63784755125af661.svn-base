package com.xiaomu.manager
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	import coco.component.Label;
	import coco.core.Application;
	import coco.manager.PopUpManager;

	public class TipManager
	{
		public function TipManager()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Get Instance
		//
		//--------------------------------------------------------------------------
		
		private static var instance:TipManager;
		
		public static function getInstance():TipManager
		{
			if (!instance)
				instance = new TipManager();
			
			return instance;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		private var curApplication:Application;
		
		public function init(application:Application):void
		{
			curApplication = application;
			
			if (curApplication && curApplication.stage)
			{
				curApplication.stage.addEventListener(MouseEvent.MOUSE_OVER, stage_rollOverHandler);
				curApplication.stage.addEventListener(MouseEvent.MOUSE_OUT, stage_rollOutHandler);
			}
			
		}
		
		private var _tipDisplay:Label;

		public function get tipDisplay():Label
		{
			if (!_tipDisplay)
			{
				_tipDisplay = new Label();
				_tipDisplay.color = 0x575757;
				_tipDisplay.autoDrawSkin = true;
				_tipDisplay.backgroundAlpha = .9
				_tipDisplay.borderAlpha = 0;
				_tipDisplay.backgroundColor = 0xffffff;
				_tipDisplay.height = 20;
				_tipDisplay.leftMargin = _tipDisplay.rightMargin = 5;
				_tipDisplay.fontFamily = "MicroSoft YaHei";
				var shadow : DropShadowFilter = new DropShadowFilter();
				shadow.alpha = 1 ;
				shadow.angle = 60 ;
				shadow.distance = 5;
				shadow.color = 0x888888;
				_tipDisplay.filters = [shadow];
			}
			
			return _tipDisplay;
		}
		
		/**
		 * 强制更新tip 
		 */
		public function forceUpdateTip(object:DisplayObject):void
		{
			var obj:ITip = object as ITip;
			if (obj && obj is DisplayObject && obj.tip)
			{
				var gp:Point = DisplayObject(obj).localToGlobal(new Point(DisplayObject(obj).width / 2 + 10, 
					DisplayObject(obj).height + 5));
				tipDisplay.text = obj.tip;
				tipDisplay.validateNow();
				if (!tipDisplay.isPopUp)
				{
					tipDisplay.x = gp.x;
					tipDisplay.y = gp.y;
					PopUpManager.addPopUp(tipDisplay);
				}
			}
		}

		
		protected function stage_rollOutHandler(event:MouseEvent):void
		{
			if (_tipDisplay && _tipDisplay.isPopUp)
				PopUpManager.removePopUp(_tipDisplay);
		}
		
		protected function stage_rollOverHandler(event:MouseEvent):void
		{
			var obj:ITip = event.target as ITip;
			if (obj && obj is DisplayObject && obj.tip && obj.tip.length > 0)
			{
				var gp:Point = DisplayObject(obj).localToGlobal(new Point(DisplayObject(obj).width / 2 + 10, 
					DisplayObject(obj).height + 5));
				tipDisplay.text = obj.tip;
				tipDisplay.validateNow();
				if (!tipDisplay.isPopUp)
				{
					tipDisplay.x = gp.x;
					tipDisplay.y = gp.y;
					PopUpManager.addPopUp(tipDisplay, null);
				}
			}
		}
		
	}
}
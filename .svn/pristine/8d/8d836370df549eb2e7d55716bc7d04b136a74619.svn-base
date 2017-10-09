package com.xiaomu.renderer
{
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	
	public class ShowListRenderer extends DefaultItemRenderer
	{
		public function ShowListRenderer()
		{
			super();
			mouseChildren = true;
			buttonMode = true;
			autoDrawSkin = false;
			addEventListener(MouseEvent.ROLL_OVER, this_rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, this_rollOutHandler);
			// 每一个ItemRenderer 都有一个data属性
			// data = {name: "皮肤1", source="jfjd....1.png"};
		}
		
		private var skinIcon : Image;
		private var closeIcon : Image;
		
		private var _mouseOver:Boolean = false;
		
		public function get mouseOver():Boolean
		{
			return _mouseOver;
		}
		
		public function set mouseOver(value:Boolean):void
		{
			_mouseOver = value;
			invalidateSkin();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontSize=15;
			labelDisplay.fontFamily = "Microsoft YaHei";
			labelDisplay.x = 80;
			labelDisplay.textAlign = TextAlign.LEFT;
			labelDisplay.color = 0x837664;
			
			skinIcon = new Image();
			skinIcon.height = skinIcon.width = 40;
			addChild(skinIcon);
			
			closeIcon = new Image();
			closeIcon.height = closeIcon.width = 30;
			closeIcon.source ="assets/close3.png";
			closeIcon.addEventListener(MouseEvent.CLICK,closeIcon_clickHandler);
			addChild(closeIcon);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (data)
			{
				labelDisplay.text = data.name;
				skinIcon.source = data.source;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			skinIcon.x = 20;
			skinIcon.y = 10;
			
			closeIcon.x = 220;
			closeIcon.y = 16;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1, mouseOver ? 0x60A1F0 : 0xF2E7C9);
			graphics.beginFill(0xD7F3FD,mouseOver ? 1 : 0);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
			
		}
		
		protected function closeIcon_clickHandler(event:MouseEvent):void
		{
			trace("closeIcon侦听到点击");
			trace("渲染器中点击的是 ： "+index);
			//利用管理器去传递这一事件给showlist的父级RoleSettingPanel 
			RoleManager.getInstance().deleteRoleSkin(index);
		}
		
		protected function this_rollOutHandler(event:MouseEvent):void
		{
			mouseOver = false;
		}
		
		protected function this_rollOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
		}
	}
}
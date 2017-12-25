package com.xiaomu.renderer {
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.TextAlign;
	
	public class ListItemRenderer extends DefaultItemRenderer {
		public function ListItemRenderer() {
			super();
			buttonMode = true;
			autoDrawSkin = false;
			addEventListener(MouseEvent.ROLL_OVER, this_rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, this_rollOutHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_ITEM,itemSelectedHandle);
		}
		
		protected function itemSelectedHandle(event:RoleEvent):void {
			selected = mouseOver;
			invalidateProperties();
			invalidateSkin();
		}
		
		private var mouseOver:Boolean = false;
		private var selected:Boolean = false;
		
		override protected function createChildren():void {
			super.createChildren();
			
			labelDisplay.fontSize = 15;
			labelDisplay.fontFamily = "Microsoft YaHei";
			labelDisplay.x = 20;
			labelDisplay.textAlign = TextAlign.LEFT;
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			if (mouseOver) {
				if (!selected) {
					labelDisplay.color = 0x1D2D51;
				}
				else
					labelDisplay.color = 0xFFFFFF;
			}
			
			else {
				if (selected) {
					labelDisplay.color = 0xffffff;
				}
				else
					labelDisplay.color = 0x968A79;
			}
			
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			graphics.clear();
			if (mouseOver) {
				if (!selected) {
					graphics.beginFill(0x3399FF, 0.1);
				}
				else
					graphics.beginFill(0x3399FF, 0.6);
			}
			
			else {
				if (selected) {
					graphics.beginFill(0x3399FF, 0.4);
				}
				else
					graphics.beginFill(0xFFFBF2);
			}
			graphics.lineStyle(1, mouseOver ? 0xF0E7CC : 0xFFFFF0);
			graphics.drawRect(-30, 0, width + 60, height);
			graphics.endFill();
		}
		
		protected function this_rollOutHandler(event:MouseEvent):void {
			mouseOver = false;
			invalidateProperties();
			invalidateSkin();
			
		}
		
		protected function this_rollOverHandler(event:MouseEvent):void {
			mouseOver = true;
			invalidateProperties();
			invalidateSkin();
		}
		
		
	}
}
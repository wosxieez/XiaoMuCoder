package com.xiaomu.view.roleview {
	import com.xiaomu.component.IconButton3;
	import com.xiaomu.data.Role;
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.MouseEvent;
	
	import coco.component.Image;
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class RoleCover extends UIComponent {
		public function RoleCover() {
			super();
			width = 90;
			height = 90;
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, this_clickHandler);
			addEventListener(MouseEvent.MOUSE_OUT, this_outHandler);
			addEventListener(MouseEvent.MOUSE_OVER, this_overHandler);
		}
		
		private var imageDisplay:Image;
		private var miniButton1:IconButton3;
		private var miniButton2:IconButton3;
		private var lab:Label;
		
		private var _mouseOver:Boolean = false;
		
		public function get mouseOver():Boolean {
			return _mouseOver;
		}
		
		public function set mouseOver(value:Boolean):void {
			if (_mouseOver == value) return;
			_mouseOver = value;
			invalidateSkin();
			invalidateDisplayList();
		}
		
		private var _selected:Boolean = false;
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected == value) return;
			_selected = value;
			invalidateProperties();
			invalidateSkin();
		}
		
		private var _role:Role;
		
		public function get role():Role {
			return _role;
		}
		
		public function set role(value:Role):void {
			_role = value;
			invalidateProperties();
		}
		
		override protected function createChildren():void {
			super.createChildren();
			
			imageDisplay = new Image();
			imageDisplay.width = 80;
			imageDisplay.height = 70;
			addChild(imageDisplay);
			
			miniButton1 = new IconButton3();
			miniButton1.source = "assets/setting1.png";
			miniButton1.tip = "设置";
			miniButton1.addEventListener(MouseEvent.CLICK, settingClickHandler);
			addChild(miniButton1);
			
			miniButton2 = new IconButton3();
			miniButton2.source = "assets/close1.png";
			miniButton2.tip = "关闭";
			miniButton2.addEventListener(MouseEvent.CLICK, closeClickHandler);
			addChild(miniButton2);
			
			lab = new Label();
			lab.height = 28;
			lab.width = width;
			lab.fontSize = 14;
			lab.fontFamily = "Microsoft YaHei";
			lab.backgroundAlpha = 1;
			addChild(lab);
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			if (role) {
				imageDisplay.source = role.icon;
				miniButton1.visible = selected;
				miniButton2.visible = selected;
				lab.text = role.name;
				lab.color = 0xffffff;
			}
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			miniButton1.x = 3;
			miniButton1.y = 3;
			
			miniButton2.x = width - miniButton2.width - 3;
			miniButton2.y = 3;
			
			imageDisplay.x = (width - imageDisplay.width) / 2;
			imageDisplay.y = 10;
			
			if (selected) {
				lab.x = 0;
				lab.y = height - lab.height + 1;
			}
			else {
				lab.x = 0;
				lab.y = mouseOver ? height - lab.height + 1 : height - lab.height + 2;
			}
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			if (selected) {
				graphics.clear();
				graphics.lineStyle(2, 0x60A1F0, 1);
				graphics.beginFill(0xC9ECF9);
				graphics.drawRoundRect(0, 0, width, height, 4, 4);
				graphics.endFill();
				//底部lab的灰色背景
				graphics.beginFill(0x696969, 0.4);
				graphics.lineStyle(0, 0x696969, 0);
				graphics.drawRoundRect(5, height - lab.height + 6, width - 10, lab.height - 9, 4, 4);
				graphics.endFill();
			}
			else {
				graphics.clear();
				graphics.lineStyle(2, mouseOver ? 0x60A1F0 : 0xF6EFDB);
				graphics.beginFill(0xFAF4E4);
				graphics.drawRoundRect(0, 0, width, height, 4, 4);
				graphics.endFill();
				//底部lab的灰色背景
				graphics.beginFill(0x696969, 0.4);
				graphics.lineStyle(0, 0x696969, 0);
				graphics.drawRoundRect(5, mouseOver ? height - lab.height + 6 : height - lab.height + 7, width - 10,
						mouseOver ? lab.height - 9 : lab.height - 8, 4, 4);
				graphics.endFill();
			}
		}
		
		protected function settingClickHandler(event:MouseEvent):void {
			//将设置按钮的操作通过事件管理器派发出去
			event.stopPropagation();
		}
		
		protected function closeClickHandler(event:MouseEvent):void {
			RoleManager.getInstance().removeRole(role);
			event.stopPropagation();
		}
		
		protected function this_clickHandler(event:MouseEvent):void {
			RoleManager.getInstance().selectRole(role);
		}
		
		protected function this_outHandler(event:MouseEvent):void {
			mouseOver = false;
		}
		
		protected function this_overHandler(event:MouseEvent):void {
			mouseOver = true;
		}
	}
}
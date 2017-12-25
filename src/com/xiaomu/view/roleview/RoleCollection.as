package com.xiaomu.view.roleview {
	import com.xiaomu.component.RadiusButton;
	import com.xiaomu.component.TextInputChange;
	import com.xiaomu.component.ToggleButtonForApp;
	import com.xiaomu.data.Role;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.RoleManager;
	import com.xiaomu.renderer.ListItemRenderer;
	import com.xiaomu.renderer.RoleItemRenderer;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.utils.UIDUtil;
	
	import coco.component.Group;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.List;
	import coco.component.Panel;
	import coco.component.VerticalAlign;
	import coco.event.UIEvent;
	import coco.layout.HorizontalLayout;
	import coco.manager.PopUpManager;
	
	public class RoleCollection extends Panel {
		public function RoleCollection() {
			width = 880;
			height = 560;
			titleHeight = 0;
			borderAlpha = backgroundAlpha = 1;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xFFFFF0;
		}
		
		
		private var roleList:List;
		private var itemList:List;
		private var itemArray:Array;
		private var groupH1:Group;
		private var groupH2:Group;
		private var icon1:Image;
		private var icon2:RadiusButton;
		private var icon3:Image;
		private var icon4:Image;
		private var textInput1:TextInputChange;
		private var textLab:Label;
		private var lab1:Label;
		private var lab2:Label;
		private var toggleButton1:ToggleButtonForApp;
		private var toggleBotton2:ToggleButtonForApp;
		private var toggleButton3:ToggleButtonForApp;
		private var toggleButton4:ToggleButtonForApp;
		
		override protected function createChildren():void {
			super.createChildren();
			groupH2 = new Group();
			groupH2.layout = new HorizontalLayout();
			addChild(groupH2);
			
			icon1 = new Image();
			icon1.source = "assets/fodder.png";
			icon1.alpha = 0.5;
			icon1.width = icon1.height = 35;
			addChild(icon1);
			
			lab1 = new Label();
			lab1.text = "我的素材库";
			lab1.fontFamily = "Microsoft YaHei";
			lab1.color = 0xC8C1B3;
			lab1.fontSize = 16;
			addChild(lab1);
			
			icon2 = new RadiusButton();
			icon2.buttonMode = true;
			icon2.width = 45;
			icon2.height = 25;
			icon2.topRightRadius = 10;
			icon2.bottomRightRadius = 10;
			icon2.mouseOutSource = "assets/seach1.png";
			icon2.mouseOverSource = "assets/seach2.png";
			addChild(icon2);
			
			textInput1 = new TextInputChange();
			textInput1.textLab = "搜索我的素材库";
			textInput1.fontSize = 15;
			textInput1.color = 0x888888;
			textInput1.maxChars = 10;
			textInput1.width = 200;
			textInput1.height = 25;
			textInput1.topLeftRadius = 11;
			textInput1.bottomLeftRadius = 11;
			textInput1.fontFamily = "Microsoft YaHei";
			addChild(textInput1);
			
			icon3 = new Image();
			icon3.buttonMode = true;
			icon3.source = "assets/visit.png";
			icon3.width = 120;
			icon3.height = 35;
			icon3.addEventListener(MouseEvent.MOUSE_OVER, icon3_OverHandler);
			icon3.addEventListener(MouseEvent.MOUSE_OUT, icon3_OutHandler);
			icon3.addEventListener(MouseEvent.CLICK, icon3_clickHandler);
			addChild(icon3);
			
			icon4 = new Image();
			icon4.buttonMode = true;
			icon4.source = "assets/close3.png";
			icon4.addEventListener(MouseEvent.CLICK, icon4_clickHandler);
			addChild(icon4);
			
			toggleButton1 = new ToggleButtonForApp();
			toggleButton1.buttonMode = true;
			toggleButton1.selected = true;
			toggleButton1.label = "全部";
			toggleButton1.fontSize = 15;
			toggleButton1.fontFamily = "Microsoft YaHei";
			toggleButton1.addEventListener(MouseEvent.CLICK, toggleButton1_clickHandler);
			groupH2.addChild(toggleButton1);
			
			toggleBotton2 = new ToggleButtonForApp();
			toggleBotton2.buttonMode = true;
			toggleBotton2.selected = false;
			toggleBotton2.label = "角色";
			toggleBotton2.fontSize = 15;
			toggleBotton2.fontFamily = "Microsoft YaHei";
			toggleBotton2.addEventListener(MouseEvent.CLICK, toggleBotton2_clickHandler);
			groupH2.addChild(toggleBotton2);
			
			toggleButton3 = new ToggleButtonForApp();
			toggleButton3.buttonMode = true;
			toggleButton3.selected = false;
			toggleButton3.label = "背景";
			toggleButton3.fontSize = 15;
			toggleButton3.fontFamily = "Microsoft YaHei";
			toggleButton3.addEventListener(MouseEvent.CLICK, toggleButton3_clickHandler);
			groupH2.addChild(toggleButton3);
			
			toggleButton4 = new ToggleButtonForApp();
			toggleButton4.buttonMode = true;
			toggleButton4.selected = false;
			toggleButton4.label = "声音";
			toggleButton4.fontSize = 15;
			toggleButton4.fontFamily = "Microsoft YaHei";
			toggleButton4.addEventListener(MouseEvent.CLICK, toggleButton4_clickHandler);
			groupH2.addChild(toggleButton4);
			
			roleList = new List();
			roleList.buttonMode = true;
			roleList.gap = roleList.padding = 35;
			roleList.paddingTop = 0;
			roleList.itemRendererColumnCount = 4;
			roleList.itemRendererHeight = 125;
			roleList.itemRendererWidth = 140;
			roleList.itemRendererClass = RoleItemRenderer;
			roleList.verticalAlign = VerticalAlign.TOP;
			roleList.horizontalAlign = HorizontalAlign.RIGHT;
			roleList.addEventListener(UIEvent.CHANGE, roleList_changeHandler);
			addChild(roleList);
			
			itemList = new List();
			itemList.labelField = "name";
			itemList.itemRendererClass = ListItemRenderer;
			itemList.autoDrawSkin = true;
			itemList.borderColor = itemList.backgroundColor = 0xFFFBF2;
			itemList.radius = 10;
			itemList.padding = 20;
			itemList.paddingTop = 0;
			itemList.itemRendererHeight = 30;
			itemList.verticalAlign = VerticalAlign.TOP;
			itemList.addEventListener(UIEvent.CHANGE, itemList_changeHandler);
			addChild(itemList);
			
			// 加载所有的角色模版数据
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
			urlLoader.load(new URLRequest("assets/collection/category.json"));
		}
		
		protected function toggleButton4_clickHandler(event:MouseEvent):void {
			toggleButton4.selected = true;
			;
			toggleButton1.selected = toggleBotton2.selected = toggleButton3.selected = false;
		}
		
		protected function toggleButton3_clickHandler(event:MouseEvent):void {
			toggleButton3.selected = true;
			toggleButton1.selected = toggleBotton2.selected = toggleButton4.selected = false;
		}
		
		protected function toggleBotton2_clickHandler(event:MouseEvent):void {
			toggleBotton2.selected = true;
			toggleButton1.selected = toggleButton3.selected = toggleButton4.selected = false;
		}
		
		protected function toggleButton1_clickHandler(event:MouseEvent):void {
			toggleButton1.selected = true;
			toggleBotton2.selected = toggleButton3.selected = toggleButton4.selected = false;
		}
		
		protected function icon4_clickHandler(event:MouseEvent):void {
			PopUpManager.removePopUp(this);
		}
		
		protected function icon3_clickHandler(event:MouseEvent):void {
			var myUrl:URLRequest = new URLRequest("http://www.hefeixiaomu.com")
			navigateToURL(myUrl, "_self");
		}
		
		protected function icon3_OutHandler(event:MouseEvent):void {
			icon3.alpha = 1;
		}
		
		protected function icon3_OverHandler(event:MouseEvent):void {
			icon3.alpha = 0.8;
		}
		
		protected function itemList_changeHandler(event:UIEvent):void {
			var category:Object = itemList.selectedItem;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, item_completeHandler);
			urlLoader.load(new URLRequest(category.source));
			itemList.selectedIndex = -1;
			
			var itemSelectEvent:RoleEvent = new RoleEvent(RoleEvent.SELECT_ITEM);
			RoleManager.getInstance().dispatchEvent(itemSelectEvent);
		}
		
		protected function item_completeHandler(event:Event):void {
			var roles:Array = JSON.parse(event.currentTarget.data) as Array;
			var newroles:Array = [];
			var role:Role;
			for each (var item:Object in roles) {
				role = new Role();
				role.name = item.name;
				role.icon = item.icon;
				role.data = item.data
				role.type = item.type
				newroles.push(role);
			}
			
			roleList.dataProvider = newroles;
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			icon1.y = 22;
			lab1.y = textInput1.y = icon2.y = icon3.y = 26;
			icon1.x = 20;
			lab1.x = 60;
			textInput1.x = 470;
			icon2.x = textInput1.x + textInput1.width;
			icon3.x = 730;
			icon3.height = 30;
			
			groupH2.width = width;
			groupH2.height = 25;
			groupH2.y = 26;
			groupH2.x = 190;
			
			icon4.x = width - icon4.width - 35;
			icon4.y = 5;
			
			roleList.width = contentWidth;
			roleList.height = contentHeight - 130;
			roleList.y = 100;
			
			itemList.height = contentHeight - 130;
			itemList.width = 160;
			itemList.x = 1;
			itemList.y = 80;
		}
		
		override protected function drawSkin():void {
			super.drawSkin();
			
			graphics.lineStyle(1, 0xF2E7C9);
			graphics.moveTo(165, 0);
			graphics.lineTo(165, height);
			graphics.moveTo(165, 70);
			graphics.lineTo(width, 70);
			graphics.endFill();
			
		}
		
		protected function urlLoader_completeHandler(event:Event):void {
			var categorys:Array = JSON.parse(event.currentTarget.data) as Array;
			itemList.dataProvider = categorys;
			
			if (itemList.dataProvider.length > 0) {
				itemList.selectedIndex = 0;
				itemList_changeHandler(null);
			}
		}
		
		protected function roleList_changeHandler(event:UIEvent):void {
			var role:Role = roleList.selectedItem as Role;
			if (role) {
				var newRole:Role = new Role();
				newRole.id = UIDUtil.createUID(); // 生成唯一ID
				newRole.name = role.name;
				newRole.icon = role.icon;
				newRole.type = role.type
				newRole.data = role.data
				RoleManager.getInstance().addRole(newRole) // 告诉角色管理器 添加新角色
				roleList.selectedIndex = -1; // 重置选中(必须)
				PopUpManager.removePopUp(this); // 关闭窗口
			}
		}		
	}
}
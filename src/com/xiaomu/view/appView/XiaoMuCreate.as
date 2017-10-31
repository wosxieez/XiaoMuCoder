package com.xiaomu.view.appView
{
	import com.xiaomu.component.AppLoading;
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.view.actionview.ActionView;
	import com.xiaomu.view.headview.Headview;
	import com.xiaomu.view.menuview.MenuView;
	import com.xiaomu.view.roleview.RoleView;
	import com.xiaomu.view.stageview.StageView;
	
	import flash.display.Screen;
	import flash.events.Event;
	
	import coco.component.Panel;
	import coco.manager.PopUpManager;
	
	public class XiaoMuCreate extends Panel
	{
		public function XiaoMuCreate()
		{
			super();
			trace();
			
			autoDrawSkin = true;
			titleHeight = 0;
			borderAlpha = backgroundAlpha = 0;
			width = 1040;
			height = 740;
			addEventListener(Event.ADDED_TO_STAGE, this_addedToStageHandler);
		}
		
		private var menuView:MenuView;
		private var stageView:StageView;
		private var roleView:RoleView;
		private var actionView:ActionView;
		private var headview : Headview;
		private var appLoading:AppLoading;
		private var appView : XiaomuApp;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			stageView = StageView.getInstance();
			stageView.y = 80;
			stageView.width = 400;
			addChild(stageView);
			
			roleView = RoleView.getInstance();
			roleView.width = 400;
			addChild(roleView);
			
			actionView = ActionView.getInstance();
			actionView.x = 400;
			actionView.y = 80;
			addChild(actionView);
			
			menuView = new MenuView();
			menuView.height = 40;
			addChild(menuView);
			
			headview = new Headview();
			headview.height = 40;
			headview.y = 40;
			addChild(headview);
			
		}
		
		protected function this_addedToStageHandler(event:Event):void
		{
			// 程序居中代码
			stage.nativeWindow.x = Screen.mainScreen.visibleBounds.x + 
				(Screen.mainScreen.visibleBounds.width - stage.stageWidth) / 2;
			stage.nativeWindow.y = Screen.mainScreen.visibleBounds.y +
				(Screen.mainScreen.visibleBounds.height - stage.stageHeight) / 2;
		}
		
		
		protected function enterApp_Handler(event:LoginEvent):void
		{
			if (appView.isPopUp) return;
			
			PopUpManager.addPopUp(appView, null, true, true, 0, .2);
		}		
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			menuView.width = width;
			
			roleView.height = (height - menuView.height) / 2;
			roleView.y = height - roleView.height;
			
			stageView.height = roleView.height;
			
			actionView.height = height - actionView.y;
			actionView.width = width - actionView.x;
		}
	}
}
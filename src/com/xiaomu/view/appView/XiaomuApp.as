package com.xiaomu.view.appView
{
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.manager.LoginManager;
	import com.xiaomu.view.loginView.ContentView;
	import com.xiaomu.view.loginView.ListView;
	import com.xiaomu.view.loginView.LoginView;
	import com.xiaomu.view.loginView.Menuheader;
	
	import coco.component.Panel;
	import coco.manager.PopUpManager;
	
	[SWF(width="930", height="600")]
//	[SWF(width="1024", height="740")]
	public class XiaomuApp extends Panel
	{
		public function XiaomuApp()
		{
			super();
			backgroundAlpha = 1;
			width = 1024;
			titleHeight = 0;
			height = 740;
			LoginManager.getInstance().addEventListener(LoginEvent.ADD_LOGIN,thisLogin_Handler);
		}
		
		private var menu:Menuheader;
		private var listview:ListView;
		private var content:ContentView;
		private var login:LoginView;
		
		
		override protected  function createChildren():void
		{
			super.createChildren();
			menu = new Menuheader();
			menu.height = 40;
			addChild(menu);
			
			listview = new ListView();
			listview.y = 40;
			addChild(listview);
			
			login = new LoginView();
			
			content = new ContentView();
			content.x = 170;
			content.y = 40;
			addChild(content);
			
		}
		
		protected function thisLogin_Handler(event:LoginEvent):void
		{
			if (login.isPopUp) return;
			
			PopUpManager.addPopUp(login, null, true, true, 0, 0);
			PopUpManager.removePopUp(this);
			
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			//			addChild(login);
		}
	}
}
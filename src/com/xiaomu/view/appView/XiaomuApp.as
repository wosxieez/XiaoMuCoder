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
			LoginManager.getInstance().addEventListener(LoginEvent.RETURN_APP,returnApp_Handler);
			LoginManager.getInstance().addEventListener(LoginEvent.EDIT_USER,editUser_Handler);
		}
		
		private var menu:Menuheader;
		private var listview:ListView;
		private var content:ContentView;
		private var login:LoginView;
		private var loginFlag: Boolean;
		private var contentFlag:Boolean;
		
		
		override protected  function createChildren():void
		{
			super.createChildren();
			menu = new Menuheader();
			menu.height = 40;
			menu.visible = true;
			addChild(menu);
			
			listview = new ListView();
			listview.y = 40;
			listview.visible = true;
			addChild(listview);
			
			login = new LoginView();
			login.visible = false;
			addChild(login);
			
			content = new ContentView();
			content.x = 170;
			content.y = 40;
			content.visible = false;
			addChild(content);	
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(loginFlag){
				login.visible = true;
				content.visible = false;
			}
			if(contentFlag){
				login.visible = false;
				content.visible = true;
			}
		}

		protected function thisLogin_Handler(event:LoginEvent):void
		{
			trace("点击切换账号进入loginView");
			contentFlag = false;
			loginFlag = true;
			invalidateProperties();
			
		}
		
		protected function returnApp_Handler(event:LoginEvent):void
		{
			trace("在loginView界面点击返回app按钮");
			contentFlag = true;
			loginFlag = false;
			invalidateProperties();

			
		}
		
		protected function editUser_Handler(event:LoginEvent):void
		{
			trace("在listView上点击设置按钮");
			contentFlag = true;
			loginFlag = false;
			invalidateProperties();
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			//			addChild(login);
		}
	}
}
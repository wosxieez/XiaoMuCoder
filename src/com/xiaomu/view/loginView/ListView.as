package com.xiaomu.view.loginView
{
	import com.xiaomu.component.Listcenterbutton;
	import com.xiaomu.component.PicIconbtn;
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.manager.LoginManager;
	
	import flash.events.MouseEvent;
	
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	
	public class ListView extends UIComponent
	{
		public function ListView()
		{
			super();
			width = 170;
			height = 700;
		}
		
		private var Icon:PicIconbtn;
		private var indexlist: Listcenterbutton;
		private var createlist: Listcenterbutton;
		private var shezhilist: Listcenterbutton;
		private var lianxilist: Listcenterbutton;
		override protected  function createChildren():void
		{
			super.createChildren();
			
			Icon= new PicIconbtn();
			Icon.radius = 48;
			Icon.x = (width - Icon.width)/2-56;
			Icon.y = (height - Icon.height)/2-294;
			Icon.source = "assets/login/pic7.jpeg";
			Icon.addEventListener(MouseEvent.CLICK,icon_clickHandle);
			addChild(Icon);
			
			indexlist = new Listcenterbutton();
			indexlist.text = "首页";
			indexlist.fontSize = 16;
			indexlist.width = width;
			indexlist.color = 0xFFFFFF;
			indexlist.height = 40;
			indexlist.mouseOverColor = 0xFFDD67;
			indexlist.mouseOutColor = 0xFFD236;
			indexlist.source = "assets/head/icon02.png";
			addChild(indexlist);
			
			createlist = new Listcenterbutton();
			createlist.text = "创作社区";
			createlist.fontSize = 16;
			createlist.width = width;
			createlist.color = 0xFFFFFF;
			createlist.height = 40;
			createlist.mouseOverColor = 0xFFDD67;
			createlist.mouseOutColor = 0xFFD236;
			createlist.source = "assets/head/icon02.png";
			createlist.addEventListener(MouseEvent.CLICK,create_clickHandle);
			addChild(createlist);
			
			shezhilist = new Listcenterbutton();
			shezhilist.text = "设置";
			shezhilist.fontSize = 16;
			shezhilist.width = width;
			shezhilist.color = 0xFFFFFF;
			shezhilist.height = 40;
			shezhilist.mouseOverColor = 0xFFDD67;
			shezhilist.mouseOutColor = 0xFFD236;
			shezhilist.source = "assets/head/icon02.png";
			shezhilist.addEventListener(MouseEvent.CLICK,icon_clickHandle);
			addChild(shezhilist);
			
			lianxilist = new Listcenterbutton();
			lianxilist.text = "联系我们";
			lianxilist.fontSize = 16;
			lianxilist.width = width;
			lianxilist.color = 0xFFFFFF;
			lianxilist.height = 40;
			lianxilist.mouseOverColor = 0xFFDD67;
			lianxilist.mouseOutColor = 0xFFD236;
			lianxilist.source = "assets/login/lianxi.png";
			addChild(lianxilist);
		}
		
		protected function icon_clickHandle(event:MouseEvent):void
		{
			var shezhiEvent : LoginEvent = new LoginEvent(LoginEvent.EDIT_USER);
			LoginManager.getInstance().dispatchEvent(shezhiEvent);
			
		}
		
		protected function create_clickHandle(event:MouseEvent):void
		{
//			PopUpManager.removePopUp(this);
			
			trace("在app界面点击返回创作面板");
			var returnCreateEvent : LoginEvent = new LoginEvent(LoginEvent.RETURN_CREATE);
			LoginManager.getInstance().dispatchEvent(returnCreateEvent);
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			indexlist.y = 200;
			createlist.y = 240;
			shezhilist.y = height-80;
			lianxilist.y = height-40;
			
			
		}
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xFFCA32);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}
package com.xiaomu.view.loginView
{
	import com.xiaomu.component.BtnMode;
	import com.xiaomu.component.IconButton;
	import com.xiaomu.component.PicIconbtn;
	import com.xiaomu.component.TextInputs;
	import com.xiaomu.view.appView.XiaomuApp;
	
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
//	[SWF(width="500", height="560")]
	
	public class LoginView extends UIComponent
	{
		public function LoginView()
		{
			super();
			width = 1024;
			height = 740;
		}
		
		private var logo : PicIconbtn;
		private var loginInputs : TextInputs;
		private var loginPsd : TextInputs;
		private var loginBtn : BtnMode;
		private var closeAppButton:IconButton;
		private var xiaomuapp:XiaomuApp;
		private var lab1:Label;
		private var lab2:Label;
		private var lab3:Label;
		private var lab4:Label;
		private var lab5:Label;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			xiaomuapp = new XiaomuApp();
			
			logo= new PicIconbtn();
			logo.radius = 56;
			logo.source = "assets/login/pic6.jpeg";
			addChild(logo);
			
			closeAppButton = new IconButton();
			closeAppButton.source = "assets/close1.png";
			closeAppButton.addEventListener(MouseEvent.CLICK, closeAppButton_clickHandler);
			addChild(closeAppButton);
			
			loginInputs = new TextInputs();
			loginInputs.width = 330;
			loginInputs.fontFamily = "Microsoft yahei";
			loginInputs.fontSize = 15;
			loginInputs.height = 40;
			loginInputs.color = 0x965E21;
			loginInputs.labelText = "请填写登录账号/手机号";
			addChild(loginInputs);
			
			loginPsd = new TextInputs();
			loginPsd.width = 330;
			loginPsd.fontFamily = "Microsoft yahei";
			loginPsd.fontSize = 15;
			loginPsd.height = 40;
			loginPsd.color = 0x965E21;
			loginPsd.labelText = "密码6-24位";
			addChild(loginPsd);
			
			lab1 = new Label();
			lab1.text = "手机验证码登录";
			lab1.buttonMode = true;
			lab1.fontFamily = "Microsoft yahei";
			lab1.fontSize = 14;
			lab1.color = 0x3399cc;

			addChild(lab1);
			
			lab2 = new Label();
			lab2.text = "忘记密码？";
			lab2.buttonMode = true;
			lab2.fontFamily = "Microsoft yahei";
			lab2.fontSize = 14;
			lab2.color = 0x3399cc;
			addChild(lab2);
			
			loginBtn = new BtnMode();
			loginBtn.text = "登录";
			loginBtn.fontSize = 17;
			loginBtn.width = 330;
			loginBtn.color = 0xFFFFFF;
			loginBtn.height = 40;
			loginBtn.bold = true;
			loginBtn.mouseOverColor = 0xFFDD67;
			loginBtn.mouseOutColor = 0xFFD236;
			addChild(loginBtn);
			
			lab3 = new Label();
			lab3.text = "没有账号？";
			lab3.buttonMode = true;
			lab3.fontFamily = "Microsoft yahei";
			lab3.fontSize = 16;
			lab3.color = 0x000000;
			addChild(lab3);
			
			lab4 = new Label();
			lab4.text = "免费注册";
			lab4.buttonMode = true;
			lab4.fontFamily = "Microsoft yahei";
			lab4.fontSize = 16;
			lab4.color = 0x3399cc;
			addChild(lab4);
			
			lab5 = new Label();
			lab5.text = "返回App";
			lab5.buttonMode = true;
			lab5.fontFamily = "Microsoft yahei";
			lab5.fontSize = 16;
			lab5.color = 0x3399cc;
			lab5.addEventListener(MouseEvent.CLICK,returnApp_clickHandle);
			addChild(lab5);
			
		}
		
		protected function returnApp_clickHandle(event:MouseEvent):void
		{
			trace("在登录界面点击返回app");
			PopUpManager.removePopUp(this);
			PopUpManager.addPopUp(xiaomuapp);
		}
		
		protected function closeAppButton_clickHandler(event:MouseEvent):void
		{
			stage.nativeWindow.close();
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			logo.x = (width - logo.width)/2-56;
			logo.y = 30;
			
			closeAppButton.x = width-closeAppButton.width-20;
			closeAppButton.y = 6;
			
			loginInputs.x = (width- loginInputs.width)/2+220;
			loginInputs.y = 260;
			loginPsd.x = (width- loginPsd.width)/2+220;
			loginPsd.y = 320;
			
			lab1.x = loginInputs.x ;
			lab1.y = 369;
			lab2.x = 826;
			lab2.y = 369;
			loginBtn.x = loginInputs.x;
			loginBtn.y = 410;
			
			lab3.x =  loginInputs.x+78;
			lab3.y = 460;
			
			lab4.x = loginInputs.x+158;
			lab4.y = 460;
			
			lab5.x = 30;
			lab5.y = height-70;
			
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,0xFCF9F5);
			
			graphics.beginFill(0xFFD900);
			graphics.drawRect(0,0,width,150);
			
			graphics.beginFill(0xffffff);
			graphics.drawRect(0,150,width,480);
			
			graphics.beginFill(0xCDFEFF);
			graphics.drawRect(0,630,width,110);
			graphics.endFill();
		}
	}
}
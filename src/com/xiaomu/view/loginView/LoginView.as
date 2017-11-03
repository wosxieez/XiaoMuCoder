package com.xiaomu.view.loginView
{
	import com.xiaomu.component.BtnMode;
	import com.xiaomu.component.IconButton;
	import com.xiaomu.component.PicIconbtn;
	import com.xiaomu.component.TextInputs;
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.manager.LoginManager;
	import com.xiaomu.view.appView.XiaomuApp;
	
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	import com.xiaomu.component.Listcenterbutton;
	
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
		private var tloginInputs : TextInputs;
		private var loginPsd : TextInputs;
		private var tloginPsd : TextInputs;
		private var loginBtn : Listcenterbutton;
		private var tyanzhengma : Listcenterbutton;
		private var closeAppButton:IconButton;
		private var xiaomuapp:XiaomuApp;
		private var lab1:Label;
		private var tlab1:Label;
		private var lab2:Label;
		private var lab3:Label;
		private var lab4:Label;
		private var lab5:Label;
		
		private var phoneloginSelect:Boolean = false;
		private var changeLabtext:String;
		
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
			loginInputs.labelText="请填写登录账号/手机号";
			loginInputs.fontSize = 15;
			loginInputs.height = 40;
			loginInputs.color = 0x965E21;
			addChild(loginInputs);
			
			tloginInputs = new TextInputs();
			tloginInputs.width = 330;
			tloginInputs.fontFamily = "Microsoft yahei";
			tloginInputs.labelText="请填写手机号";
			tloginInputs.fontSize = 15;
			tloginInputs.height = 40;
			tloginInputs.color = 0x965E21;
//			addChild(tloginInputs);
			
			loginPsd = new TextInputs();
			loginPsd.width = 330;
			loginPsd.fontFamily = "Microsoft yahei";
			loginPsd.fontSize = 15;
			loginPsd.height = 40;
			loginPsd.color = 0x965E21;
			loginPsd.labelText = "密码6-24位";
			addChild(loginPsd);
			
			tloginPsd = new TextInputs();
			tloginPsd.width = 210;
			tloginPsd.fontFamily = "Microsoft yahei";
			tloginPsd.fontSize = 15;
			tloginPsd.height = 40;
			tloginPsd.color = 0x965E21;
			tloginPsd.labelText = "请输入验证码";
//			addChild(tloginPsd);
			
			tyanzhengma = new Listcenterbutton();
			tyanzhengma.text = "获取验证码";
			tyanzhengma.fontSize = 15;
			tyanzhengma.width = 110;
			tyanzhengma.color = 0xFFFFFF;
			tyanzhengma.height = 40;
			tyanzhengma.bold = true;
			tyanzhengma.mouseOverColor = 0x5CDFFF;
			tyanzhengma.mouseOutColor = 0x59d4f4;
//			addChild(tyanzhengma);
			
			lab1 = new Label();
			lab1.text = "手机验证码登录";
			lab1.buttonMode = true;
			lab1.fontFamily = "Microsoft yahei";
			lab1.fontSize = 14;
			lab1.color = 0x3399cc;
			lab1.addEventListener(MouseEvent.CLICK,phone_loginHandle);
			addChild(lab1);
			
			tlab1 = new Label();
			tlab1.text = "账号密码登录";
			tlab1.buttonMode = true;
			tlab1.fontFamily = "Microsoft yahei";
			tlab1.fontSize = 14;
			tlab1.color = 0x3399cc;
			tlab1.addEventListener(MouseEvent.CLICK,number_loginHandle);
//			addChild(tlab1);
			
			lab2 = new Label();
			lab2.text = "忘记密码？";
			lab2.buttonMode = true;
			lab2.fontFamily = "Microsoft yahei";
			lab2.fontSize = 14;
			lab2.color = 0x3399cc;
			addChild(lab2);
			
			loginBtn = new Listcenterbutton();
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
		
		protected function number_loginHandle(event:MouseEvent):void
		{
			trace("账号密码登录点击");
			addChild(loginInputs);
			addChild(loginPsd);
			addChild(lab1);
			addChild(lab2);
			removeChild(tloginInputs);
			removeChild(tloginPsd);
			removeChild(tyanzhengma);
			removeChild(tlab1);
		}
		
		protected function phone_loginHandle(event:MouseEvent):void
		{
			trace("手机验证码点击");
			removeChild(loginInputs);
			removeChild(loginPsd);
			removeChild(lab1);
			removeChild(lab2);
			addChild(tloginInputs);
			addChild(tloginPsd);
			addChild(tyanzhengma);
			addChild(tlab1);
			
		}
		
		protected function returnApp_clickHandle(event:MouseEvent):void
		{
			trace("在登录界面点击返回app");
//			trace("在app界面点击返回创作面板");
			var returnAppEvent : LoginEvent = new LoginEvent(LoginEvent.RETURN_APP);
			LoginManager.getInstance().dispatchEvent(returnAppEvent);
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
			
			tloginInputs.x = loginInputs.x = (width- loginInputs.width)/2+220;
			tloginInputs.y = loginInputs.y = 260;
			tloginPsd.x = loginPsd.x = (width- loginPsd.width)/2+220;
			tyanzhengma.x = tloginPsd.x + tloginPsd.width + 10;
			tloginPsd.y = tyanzhengma.y = loginPsd.y = 320;
			
			tlab1.x = lab1.x = loginInputs.x ;
			tlab1.y = lab1.y = 369;
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
		
		override protected function commitProperties():void
		{
			super.commitProperties();
//			loginInputs.labelText = changeLabtext;
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
package com.xiaomu.view.loginView
{
	import flash.events.MouseEvent;
	import coco.component.Label;
	import coco.core.UIComponent;
	import com.xiaomu.Area.InputArea;
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.manager.LoginManager;
	
	public class ContentView extends UIComponent
	{
		public function ContentView()
		{
			super();
			width = 854;
			height = 560;
		}
		
		private var lab:Label;
		private var lab1:Label;
		private var inputs: InputArea;
		private var mouseOver:Boolean = false;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = "个人信息";
			lab.color = 0xA0A0A0;
			lab.y = 6;
			lab.x = 10;
			lab.fontSize = 16;
			lab.fontFamily = "Microsoft Yahei";
			addChild(lab);
			
			lab1 = new Label();
			lab1.text = "切换账号";
			lab1.y = 6;
			lab1.x = 750;
			lab1.fontSize = 14;
			lab1.buttonMode = true;
			lab1.fontFamily = "Microsoft Yahei";
			lab1.addEventListener(MouseEvent.MOUSE_OVER,lab1_overHandle);
			lab1.addEventListener(MouseEvent.MOUSE_OUT,lab1_outHandle);
			lab1.addEventListener(MouseEvent.CLICK,lab1_ClickHandle);
			addChild(lab1);
			
			inputs = new InputArea();
			inputs.x = 16;
			inputs.y = 60;
			addChild(inputs);
			
		}
		
		protected function lab1_outHandle(event:MouseEvent):void
		{
			mouseOver =false;
			invalidateProperties();
		}
		
		protected function lab1_ClickHandle(event:MouseEvent):void
		{
			trace("点击切换账号");
			var loginInEvent : LoginEvent = new LoginEvent(LoginEvent.ADD_LOGIN);
			LoginManager.getInstance().dispatchEvent(loginInEvent);
		}
		
		protected function lab1_overHandle(event:MouseEvent):void
		{
			mouseOver = true;
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			lab1.color = mouseOver ? 0x82DBFF :0xA0A0A0;
			
		}
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xf2f2f2);
			graphics.drawRect(0,0,width,40);
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,40,width,height-40);
			graphics.endFill();
		}
	}
}
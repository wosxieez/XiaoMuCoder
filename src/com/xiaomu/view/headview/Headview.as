package com.xiaomu.view.headview
{
	import com.xiaomu.component.BtnMode;
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.manager.LoginManager;
	import com.xiaomu.renderer.ListItemRenderer;
	
	import flash.events.MouseEvent;
	
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	import coco.manager.PopUpManager;
	
	public class Headview extends UIComponent
	{
		public function Headview()
		{
			super();
			width = 1024;
		}
		
		private var btn1:BtnMode;
		private var btn2:BtnMode;
		private var btn3:BtnMode;
		private var loginBtn:BtnMode;
		private var btn_upload : BtnMode;
		private var list:List;
		private var list1:List;
		private var list2:List;
		
		private var inputs:InputText;
		private var icon1:BtnMode;
		private var icon2:BtnMode;
		private var icon3:BtnMode;
		private var arr:Array=["打开","新建","另存为","保存到本地","打开本地作品"];
		private var arr1:Array;
		
		override protected function createChildren():void
		{
			super.createChildren();
			btn1 = new BtnMode();
			btn1.text = "文件";
			btn1.width = 80;
			btn1.height = 36;
			btn1.color = 0x965E21;
			btn1.mouseOverColor = 0xFFDD67;
			btn1.mouseOutColor = 0xFFD41D;
			btn1.fontSize = 14;
			btn1.source = "assets/head/icon01.png";
			btn1.addEventListener(MouseEvent.MOUSE_OVER,btn1_overHandle);
			btn1.addEventListener(MouseEvent.MOUSE_OUT,btn1_outHandle);
			addChild(btn1);
			
			btn2 = new BtnMode();
			btn2.text = "舞台";
			btn2.width = 80;
			btn2.fontSize = 14;
			btn2.height = 36;
			btn2.color = 0x965E21;
			btn2.mouseOverColor = 0xFFDD67;
			btn2.mouseOutColor = 0xFFD236;
			btn2.source = "assets/head/icon00.png";
			addChild(btn2);
			
			btn3 = new BtnMode();
			btn3.text = "保存";
			btn3.fontSize = 14;
			btn3.width = 80;
			btn3.color = 0x965E21;
			btn3.height = 36;
			btn3.mouseOverColor = 0xFFDD67;
			btn3.mouseOutColor = 0xFFD236;
			btn3.source = "assets/head/icon02.png";
			addChild(btn3);
			
			list=new List();
			list.labelField = "name";
			list.itemRendererClass = ListItemRenderer;
			list.autoDrawSkin = true;
			list.height = 180;
			list.width = 120;
			list.borderColor = list.backgroundColor = 0xFFFBF2;
			list.itemRendererHeight = 36;
			list.verticalAlign = VerticalAlign.MIDDLE;
			list.addEventListener(MouseEvent.MOUSE_OVER,list_overHandle);
			list.addEventListener(MouseEvent.MOUSE_OUT,list_outHandle);
			//			addChild(list);
			
			inputs = new InputText();
			inputs.width = 140;
			inputs.labelText = "还想放假不";
			addChild(inputs);
			
			btn_upload = new BtnMode();
			btn_upload.text = "上传";
			btn_upload.width = 66;
			btn_upload.fontSize = 12;
			btn_upload.height = 28;
			btn_upload.color = 0xffffff;
			btn_upload.mouseOverColor =0x68CDFF ;
			btn_upload.mouseOutColor = 0x74B2FE;
			btn_upload.source = "assets/head/up.png";
			addChild(btn_upload);
			
			icon1 = new BtnMode();
			icon1.width = 31;
			icon1.height = 30;
			icon1.mouseOverColor = 0xFFDD67;
			icon1.mouseOutColor = 0xFFD236;
			icon1.source = "assets/head/icon2.png";
			icon1.addEventListener(MouseEvent.MOUSE_OVER,icon1_overHandle);
			icon1.addEventListener(MouseEvent.MOUSE_OUT,icon1_outHandle);
			addChild(icon1);
			
			icon2 = new BtnMode();
			icon2.width = 31;
			icon2.height = 30;
			icon2.mouseOverColor = 0xFFDD67;
			icon2.mouseOutColor = 0xFFD236;
			icon2.source = "assets/head/icon1.png";
			addChild(icon2);
			
			icon3 = new BtnMode();
			icon3.width = 31;
			icon3.height = 30;
			icon3.mouseOverColor = 0xFFDD67;
			icon3.mouseOutColor = 0xFFD236;
			icon3.source = "assets/head/icon3.png";
			addChild(icon3);
			
			list1= new List();
			list1.itemRendererClass = ListItemRenderer;
			arr1 = new Array("背包");
			list1.dataProvider = arr1;
			//		addChild(list1);
			
			loginBtn = new BtnMode();
			loginBtn.text = " 进入APP";
			loginBtn.fontSize = 14;
			loginBtn.width = 120;
			loginBtn.color = 0x965E21;
			loginBtn.height = 36;
			loginBtn.mouseOverColor = 0xFFDD67;
			loginBtn.mouseOutColor = 0xFFD236;
			loginBtn.source = "assets/head/loginIcon.png";
			loginBtn.addEventListener(MouseEvent.CLICK,login_clickHandle);
			addChild(loginBtn);
			
		}
		
		protected function login_clickHandle(event:MouseEvent):void
		{
			trace("点击进入APP按钮");
			var enterAPPEvent : LoginEvent = new LoginEvent(LoginEvent.ENTER_APP);
			LoginManager.getInstance().dispatchEvent(enterAPPEvent);
			
		}
		
		protected function list_outHandle(event:MouseEvent):void
		{
			PopUpManager.removePopUp(list);
		}
		
		protected function list_overHandle(event:MouseEvent):void
		{
			PopUpManager.addPopUp(list);
		}
		
		protected function icon1_overHandle(event:MouseEvent):void
		{
			PopUpManager.addPopUp(list1);
		}
		
		protected function  icon1_outHandle(event:MouseEvent):void
		{
			PopUpManager.removePopUp(list1);
		}
		
		protected function btn1_outHandle(event:MouseEvent):void
		{
			PopUpManager.removePopUp(list);
		}
		
		protected function btn1_overHandle(event:MouseEvent):void
		{
			PopUpManager.addPopUp(list);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			list.dataProvider = arr;
			inputs.fontFamily = "Microsoft yahei";
			inputs.fontSize = 14;
			inputs.color = 0x965E21;
		}
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			btn1.x = list.x =3;
			btn2.x = btn1.x + btn1.width;
			btn3.x=btn2.x+btn2.width;
			btn1.y = btn2.y=btn3.y=2;
			
			list.y = btn1.height+42;
			inputs.x = 300;
			inputs.y=5;
			
			btn_upload.x = 450;
			btn_upload.y = icon1.y = icon2.y = icon3.y = 6;
			
			icon1.x =list1.x= 640;
			list1.y = 33;
			icon2.x = 640 + icon1.width+4;
			icon3.x = icon2.x + icon2.width +4;
			
			loginBtn.x = 820;
			loginBtn.y = 2;
		}
		
		override protected  function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.beginFill(0xFFD236);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}
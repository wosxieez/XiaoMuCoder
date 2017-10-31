package com.xiaomu.Area
{
	import flash.events.MouseEvent;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	import com.xiaomu.component.ToggleButtonForApp;
	import com.xiaomu.component.TextInputs;
	import com.xiaomu.component.DateSelect;
	
	public class InputArea extends UIComponent
	{
		public function InputArea()
		{
			super();
		}
		
		private var lab1:Label;
		private var lab2:Label;
		private var lab3:Label;
		private var lab4:Label;
		private var lab5:Label;
		private var lab6:Label;
		private var lab7:Label;
		
		private var input1:TextInputs;
		private var input2:TextInputs;
		private var input3:TextInputs;
		private var input4:TextInputs;
		private var input5:TextInputs;
		
		private var toggleButton1:ToggleButtonForApp;
		private var toggleButton2:ToggleButtonForApp;
		
		private var select : DateSelect;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab1 = new Label();
			lab1.text = "用户名";
			addChild(lab1);
			
			lab2 = new Label();
			lab2.text = "绑定手机";
			addChild(lab2);
			
			lab3 = new Label();
			lab3.text = "昵称";
			addChild(lab3);
			
			lab4 = new Label();
			lab4.text = "真实姓名";
			addChild(lab4);
			
			lab5 = new Label();
			lab5.text = "性别";
			addChild(lab5);
			
			lab6 = new Label();
			lab6.text = "生日";
			addChild(lab6);
			
			lab7 = new Label();
			lab7.text = "密码";
			addChild(lab7);
			
			input1 = new TextInputs();
			input1.labelText = "请输入你的用户名";
			addChild(input1);
			
			input2 = new TextInputs();
			input2.labelText = "请输入你绑定手机号";
			addChild(input2);
			
			input3 = new TextInputs();
			input3.labelText = "你的昵称";
			addChild(input3);
			
			input4 = new TextInputs();
			input4.labelText = "你的真实姓名";
			addChild(input4);
			
			input5 = new TextInputs();
			input5.labelText = "请输入密码";
			addChild(input5);
			
			toggleButton1 = new ToggleButtonForApp();
			toggleButton1.buttonMode = true;
			toggleButton1.selected = true;
			toggleButton1.label = "男";
			toggleButton1.addEventListener(MouseEvent.CLICK,toggleButton1_clickHandler);
			addChild(toggleButton1);
			
			toggleButton2 = new ToggleButtonForApp();
			toggleButton2.buttonMode = true;
			toggleButton2.selected = false;
			toggleButton2.label = "女";
			toggleButton2.addEventListener(MouseEvent.CLICK,toggleButton2_clickHandler);
			addChild(toggleButton2);
			
			select = new DateSelect();
			addChild(select);
			
		}
		
		protected function toggleButton1_clickHandler(event:MouseEvent):void
		{
			toggleButton1.selected = true;
			toggleButton2.selected =false;
		} 
		
		protected function toggleButton2_clickHandler(event:MouseEvent):void
		{
			toggleButton2.selected = true;
			toggleButton1.selected =false;
		} 
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab1.fontFamily = lab2.fontFamily = lab3.fontFamily = lab4.fontFamily =lab5.fontFamily =lab6.fontFamily =lab7.fontFamily = "Microsoft yahei";
			lab1.fontSize = lab2.fontSize = lab3.fontSize = lab4.fontSize = lab5.fontSize = lab6.fontSize = lab7.fontSize = 16;
			lab1.color = lab2.color = lab3.color = lab4.color = lab5.color = lab6.color = lab7.color =0xA0A0A0 ;
			//			lab2.textAlign = TextAlign.RIGHT;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			lab1.x = lab2.x = lab3.x = lab4.x = lab5.x = lab6.x = lab7.x =24;
			lab1.y = input1.y = 30 ;
			lab2.y =  input2.y =86;
			lab3.y = input3.y = 144;
			lab4.y = input4.y = 202;
			lab5.y = toggleButton1.y = toggleButton2.y = 260;
			lab6.y= select.y =  318  ;
			lab7.y = input5.y = 376;
			
			input1.x = input2.x = input3.x = input4.x=input5.x = toggleButton1.x = select.x=120 ;
			toggleButton2.x = 200;
		}
	}
}
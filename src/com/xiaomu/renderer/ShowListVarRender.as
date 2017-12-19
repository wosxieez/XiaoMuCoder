package com.xiaomu.renderer
{
	import com.xiaomu.component.TextInputs;
	import com.xiaomu.component.ToggleButtonForApp;
	
	import flash.events.MouseEvent;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Label;
	
	public class ShowListVarRender extends DefaultItemRenderer
	{
		public function ShowListVarRender()
		{
			super();
		}
		
		private var lab:Label;
		private var inputVarName:TextInputs;
		private var globalVar:ToggleButtonForApp;
		private var limitedVar:ToggleButtonForApp;
		override protected function createChildren():void
		{
			super.createChildren();
			
			lab = new Label();
			lab.text = "{n}";
			
			inputVarName = new TextInputs();
			inputVarName.width = 100;
			inputVarName.fontFamily = "Microsoft yahei";
			inputVarName.fontSize = 15;
			inputVarName.height = 24;
			inputVarName.color = 0x965E21;
			inputVarName.labelText = "请输入变量名";
			addChild(inputVarName);
			
			globalVar = new ToggleButtonForApp();
			globalVar.buttonMode = true;
			globalVar.selected = true;
			globalVar.label = "全局变量";
			globalVar.addEventListener(MouseEvent.CLICK,toggleButton1_clickHandler);
			addChild(globalVar);
			
			limitedVar = new ToggleButtonForApp();
			limitedVar.buttonMode = true;
			limitedVar.selected = false;
			limitedVar.label = "角色变量";
			limitedVar.addEventListener(MouseEvent.CLICK,toggleButton2_clickHandler);
			addChild(limitedVar);
			
			
			
		}
		
		protected function toggleButton1_clickHandler(event:MouseEvent):void
		{
			globalVar.selected = true;
			limitedVar.selected =false;
		} 
		
		protected function toggleButton2_clickHandler(event:MouseEvent):void
		{
			limitedVar.selected = true;
			globalVar.selected =false;
		} 
	}
}
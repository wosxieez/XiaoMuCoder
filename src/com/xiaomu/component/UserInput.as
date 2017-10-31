package com.xiaomu.component
{
	import coco.component.Label;
	import coco.core.UIComponent;
	
	public class UserInput extends UIComponent
	{
		public function UserInput()
		{
			super();
		}
		
		private var Inputlab:Label;
		private var text : String;
		override protected function createChildren():void
		{
			super.createChildren();
			
			Inputlab = new Label();
			addChild(Inputlab);
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			Inputlab.text = text;
			Inputlab.fontFamily = "Microsoft yahei";
			Inputlab.fontSize = 16;
			Inputlab.x = 6;
			Inputlab.y = 50;
		}
	}
}
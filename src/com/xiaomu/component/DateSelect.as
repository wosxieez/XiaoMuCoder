package com.xiaomu.component
{
	import com.xiaomu.renderer.SelectboxRender;
	
	import coco.component.Label;
	import coco.core.UIComponent;
	
	
	public class DateSelect extends UIComponent
	{
		public function DateSelect()
		{
			super();
		}
		
		private var selectYear: DropList;
		private var selectMonth: DropList;
		private var selectDay: DropList;
		
		private var lab1:Label;
		private var lab2:Label;
		private var lab3:Label;
		
		private var arr:Array = ["1995","1996","1997","1995","1996","1997","1995","1996","1997"];
		private var arr2:Array =  ["01","02","03","04","05","06","07","08","09"];
		private var arr3:Array = ["01","02","03","04","05","06","07","08","09"];
		
		override protected function createChildren():void
		{
			super.createChildren();
			selectYear = new DropList();
			selectYear.itemRendererClass = SelectboxRender;
			selectYear.dataProvider = arr;
			addChild(selectYear);
			
			selectMonth = new DropList();
			
			selectMonth.itemRendererClass = SelectboxRender;
			selectMonth.dataProvider = arr2;
			addChild(selectMonth);
			
			selectDay = new DropList();
			selectDay.itemRendererClass = SelectboxRender;
			selectDay.dataProvider = arr3;
			addChild(selectDay);
			
			lab1 = new Label();
			addChild(lab1);
			
			lab2 = new Label();
			addChild(lab2);
			
			lab3 = new Label();
			addChild(lab3);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			lab1.text = "年";
			lab2.text = "月";
			lab3.text = "日";
			lab1.fontSize = lab2.fontSize = lab3.fontSize = 16;
			lab1.color = lab2.color = lab3.color = 0xA0A0A0;
			lab1.fontFamily = lab2.fontFamily = lab3.fontFamily = "Microsoft yahei";
			
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			
			lab1.y = lab2.y = lab3.y=7;
			selectYear.y = selectMonth.y = selectDay.y = 4;
			lab1.x = selectYear.width+2;
			lab2.x = lab1.x +selectMonth.width+27;
			lab3.x = lab2.x + selectDay.width+27;
			selectMonth .x = 100;
			selectDay.x = 200;
		}
	}
}
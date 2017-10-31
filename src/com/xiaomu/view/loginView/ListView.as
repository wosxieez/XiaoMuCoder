package com.xiaomu.view.loginView
{
	import com.xiaomu.component.PicIconbtn;
	import com.xiaomu.renderer.AppMenuListItemRender;
	
	import coco.component.List;
	import coco.component.VerticalAlign;
	import coco.core.UIComponent;
	
	
	public class ListView extends UIComponent
	{
		public function ListView()
		{
			super();
			width = 170;
			height = 700;
		}
		
		private var Icon:PicIconbtn;
		private var list:List;
		private var arr:Array=["首页","我的课程","创作社区"];
		override protected  function createChildren():void
		{
			super.createChildren();
			
			Icon= new PicIconbtn();
			Icon.radius = 48;
			Icon.x = (width - Icon.width)/2-56;
			Icon.y = (height - Icon.height)/2-294;
			Icon.source = "assets/login/pic7.jpeg";
			addChild(Icon);
			
			list=new List();
			list.dataProvider = arr;
			list.itemRendererClass = AppMenuListItemRender;
			list.itemRendererHeight = 30;
			list.y = 180;
			list.width = width;
			//			list.height =450;
			list.verticalAlign = VerticalAlign.MIDDLE;
			addChild(list);
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			
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
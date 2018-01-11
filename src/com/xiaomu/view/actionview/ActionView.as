package com.xiaomu.view.actionview
{
	import com.xiaomu.data.Role;
	import com.xiaomu.renderer.ActionBarItemRenderer;
	import com.xiaomu.util.Theme;
	
	import coco.component.ButtonGroup;
	import coco.component.SkinComponent;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	
	/**
	 * 脚本视图 787125
	 * @author coco
	 */	
	public class ActionView extends SkinComponent
	{
		public function ActionView()
		{
			super();
			
			borderAlpha = backgroundAlpha = 1;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xFEFBF0;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Get Instance
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private static var instance:ActionView;
		
		public static function getInstance():ActionView
		{
			if (!instance)
				instance = new ActionView();
			
			return instance;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var actionBarData:Array = [
			{name:"事件", color:Theme.EVENT_COLOR, source:"assets/role/role1.png"}, 
			{name:"控制", color:Theme.CONTROL_COLOR, source:"assets/role/role2.png"}, 
			{name:"动作", color:Theme.ACTION_COLOR, source:"assets/role/role3.png"}, 
			{name:"外观", color:Theme.SKIN_COLOR, source:"assets/role/role4.png"}, 
			{name:"声音", color:Theme.VOICE_COLOR, source:"assets/role/role5.png"}, 
			{name:"运算", color:Theme.OPERATION_COLOR, source:"assets/role/role6.png"}];
		
		private var actionBar:ButtonGroup;
		private var actionContent:ActionContent;
		private var actionList:ActionList;
		private var eventList:EventList;
		private var controlList:ControlList;
		private var apperenceList:ApperenceList;
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
//			actionBar = new ButtonGroup();
			actionBar = new ButtonGroup();
			actionBar.itemRendererColumnCount = 1;
			actionBar.dataProvider = actionBarData;
			actionBar.width = 100;
			actionBar.padding = 6;
			actionBar.gap = 6;
			actionBar.itemRendererHeight = 35;
			actionBar.itemRendererClass = ActionBarItemRenderer;
			actionBar.addEventListener(UIEvent.CHANGE, actionBar_changeHandler);
			addChild(actionBar);
			
			actionContent = new ActionContent();
			actionContent.x = 100;
			addChild(actionContent);
			
			eventList = new EventList();
			eventList.x = 100;
			eventList.width = 200;
			eventList.height = height;
			
			controlList = new ControlList();
			controlList.x = 100;
			controlList.width = 200;
			controlList.height = height;
			
			actionList = new ActionList();
			actionList.x = 100;
			actionList.width = 200;
			actionList.height = height;
			
			apperenceList = new ApperenceList();
			apperenceList.x = 100;
			apperenceList.width = 200;
			apperenceList.height = height;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			actionBar.height = height;
			actionContent.width = width - actionContent.x;
			actionContent.height = height;
			
//			if (actionList)
				actionList.height = controlList.height = eventList.height =  apperenceList.height = height;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.beginFill(0xF9F4E6);
			graphics.drawRect(0, 0, 100, height);
			graphics.endFill();
		}
		
		protected function actionBar_changeHandler(event:UIEvent):void
		{
			switch (actionBar.selectedIndex) {
				case 0:
					PopUpManager.removeAllPopUp();
					PopUpManager.addPopUp(eventList, this, false, true);
					break;
				
				case 1:
					PopUpManager.removeAllPopUp();
					PopUpManager.addPopUp(controlList, this, false, true);
					break;
				
				case 2:
					PopUpManager.removeAllPopUp();
					PopUpManager.addPopUp(actionList, this, false, true);
					break;
				
				case 3:
					PopUpManager.removeAllPopUp();
					PopUpManager.addPopUp(apperenceList, this, false, true);
					break;
				
				default:
					trace("暂时没有");
					break;
			}
			
			actionBar.selectedIndex = -1;
			
//				if (!actionList)
//					{
//						actionList = new ActionList();
//						actionList.x = 100;
//						actionList.width = 200;
//						actionList.height = height;
//					 }
//							
//				if (!actionList.isPopUp)
//					PopUpManager.addPopUp(actionList, this, false, true);
			
	
			
		}
		
	}
}
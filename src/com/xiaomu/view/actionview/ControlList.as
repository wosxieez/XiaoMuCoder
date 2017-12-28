package com.xiaomu.view.actionview
{
	import com.xiaomu.actioncomponent.ContinueComponent;
	import com.xiaomu.component.ActionComponent;
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.manager.ActionComponentManager;
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import coco.component.Group;
	import coco.component.HorizontalAlign;
	import coco.layout.VerticalLayout;
	import coco.manager.PopUpManager;
	
	public class ControlList extends Group
	{
		public function ControlList()
		{
			super();
			
			var vlayout:VerticalLayout = new VerticalLayout();
			vlayout.padding = vlayout.gap = 20;
			vlayout.horizontalAlign = HorizontalAlign.CENTER;
			layout = vlayout;
			
			autoDrawSkin = true;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xF9F4E6;
			addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler);
		}
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var continue1:ContinueComponent = new ContinueComponent();
			continue1.mouseChildren = false;
			continue1.menuEnabled = false;
			addChild(continue1);
		}
		
		protected function this_mouseDownHandler(event:MouseEvent):void
		{
			if (!RoleManager.getInstance().currentRole) 
			{
				AppAlert.show("请选择角色");
				return;
			}
			
			var actionComponent:ActionComponent = event.target as ActionComponent;
			if (actionComponent)
			{
				var globalPoint:Point = actionComponent.localToGlobal(new Point(0, 0));
				
				var actionComponentClass:Class = getDefinitionByName(getQualifiedClassName(actionComponent)) as Class;
				var newActionComponent:ActionComponent = new actionComponentClass() as ActionComponent;
				newActionComponent.x = globalPoint.x;
				newActionComponent.y = globalPoint.y;
				ActionComponentManager.getInstance().doDraggingActionComponent(newActionComponent);
				
				// close this view
				PopUpManager.removePopUp(this);
			}
		}
	}
}
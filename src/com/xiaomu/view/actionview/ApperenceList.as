package com.xiaomu.view.actionview
{
	import com.xiaomu.actioncomponent.AddDialogActionComponent;
	import com.xiaomu.actioncomponent.HiddenActionComponent;
	import com.xiaomu.actioncomponent.HiddenAfterMomentsActionComponent;
	import com.xiaomu.actioncomponent.ShowActionComponent;
	import com.xiaomu.actioncomponent.ShowAfterMomentsActionComponent;
	import com.xiaomu.actioncomponent.TestActionComponent;
	import com.xiaomu.actioncomponent.TestActionComponent2;
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
	
	public class ApperenceList extends Group
	{
		public function ApperenceList()
		{
			super();
			
			var vlayout:VerticalLayout = new VerticalLayout();
			vlayout.padding = vlayout.gap = 20;
			vlayout.horizontalAlign = HorizontalAlign.LEFT;
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
			
			var addDialogActionComponent:AddDialogActionComponent = new AddDialogActionComponent();
			addDialogActionComponent.mouseChildren = false;
			addDialogActionComponent.menuEnabled = false;
			addChild(addDialogActionComponent);
			
			var hiddenActionComponent:HiddenActionComponent = new HiddenActionComponent();
			hiddenActionComponent.mouseChildren = false;
			hiddenActionComponent.menuEnabled = false;
			addChild(hiddenActionComponent);
			
			var showActionComponent:ShowActionComponent = new ShowActionComponent();
			showActionComponent.mouseChildren = false;
			showActionComponent.menuEnabled = false;
			addChild(showActionComponent);
			
			var showAfterMomentsActionComponent:ShowAfterMomentsActionComponent = new ShowAfterMomentsActionComponent();
			showAfterMomentsActionComponent.mouseChildren = false;
			showAfterMomentsActionComponent.menuEnabled = false;
			addChild(showAfterMomentsActionComponent);
			
			var hiddenAfterMomentsActionComponent:HiddenAfterMomentsActionComponent = new HiddenAfterMomentsActionComponent();
			hiddenAfterMomentsActionComponent.mouseChildren = false;
			hiddenAfterMomentsActionComponent.menuEnabled = false;
			addChild(hiddenAfterMomentsActionComponent);
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
package com.xiaomu.view.actionview
{
	import com.xiaomu.actioncomponent.AddSizeActionComponent;
	import com.xiaomu.actioncomponent.MoveToXActionComponent;
	import com.xiaomu.actioncomponent.MoveToYActionComponent;
	import com.xiaomu.actioncomponent.MoveXActionComponent;
	import com.xiaomu.actioncomponent.MoveYActionComponent;
	import com.xiaomu.actioncomponent.RotateActionComponent;
	import com.xiaomu.actioncomponent.ShakeActionComponent;
	import com.xiaomu.actioncomponent.SubtractXActionComponent;
	import com.xiaomu.actioncomponent.SubtractYActionComponent;
	import com.xiaomu.actioncomponent.XandYComponent;
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
	
	
	/**
	 * 脚本列表视图 
	 * @author coco
	 */	
	public class ActionList extends Group
	{
		public function ActionList()
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
			
			var moveXAction:MoveXActionComponent = new MoveXActionComponent();
			moveXAction.mouseChildren = false;
			moveXAction.menuEnabled = false;
			addChild(moveXAction);
			
			var moveToXAction:MoveToXActionComponent = new MoveToXActionComponent();
			moveToXAction.mouseChildren = false;
			moveToXAction.menuEnabled = false;
			addChild(moveToXAction);
			
			var subtractXAction:SubtractXActionComponent = new SubtractXActionComponent();
			subtractXAction.mouseChildren = false;
			subtractXAction.menuEnabled = false;
			addChild(subtractXAction);
			
			var moveYAction2:MoveYActionComponent = new MoveYActionComponent();
			moveYAction2.mouseChildren = false;
			moveYAction2.menuEnabled = false;
			addChild(moveYAction2);
			
			var moveToYAction:MoveToYActionComponent = new MoveToYActionComponent();
			moveToYAction.mouseChildren = false;
			moveToYAction.menuEnabled = false;
			addChild(moveToYAction);
			
			var subtractYAction:SubtractYActionComponent = new SubtractYActionComponent();
			subtractYAction.mouseChildren = false;
			subtractYAction.menuEnabled = false;
			addChild(subtractYAction);
			
			var rotate30Degree:RotateActionComponent = new RotateActionComponent();
			rotate30Degree.mouseChildren = false;
			rotate30Degree.menuEnabled = false;
			addChild(rotate30Degree);
			
			var XangYAction:XandYComponent = new XandYComponent();
			XangYAction.mouseChildren = false;
			XangYAction.menuEnabled = false;
			addChild(XangYAction);
			
			var Shake:ShakeActionComponent = new ShakeActionComponent();
			Shake.mouseChildren = false;
			Shake.menuEnabled = false;
			addChild(Shake);
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
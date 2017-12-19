package com.xiaomu.view.stageview
{
	import com.xiaomu.data.Action;
	import com.xiaomu.data.Role;
	
	import flash.geom.Matrix;
	
	import coco.component.Image;
	import coco.core.UIComponent;
	import coco.core.coco;
	
	public class RoleComponent extends UIComponent
	{
		public function RoleComponent()
		{
			super();
			
			mouseChildren = false;
			width = 100;
			height = 100;
		}
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Properties
		//
		//----------------------------------------------------------------------------------------------------------------
		
		private var imgDisplay:Image;
		
		private var _role:Role;

		public function get role():Role
		{
			return _role;
		}

		public function set role(value:Role):void
		{
			_role = value;
			invalidateProperties();
		}

		
		/**
		 * 脚本数据 
		 */		
		public var actions:Vector.<Action> = new Vector.<Action>();
		
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			imgDisplay = new Image();
			addChild(imgDisplay);
		}
		
		
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (role)
			{
				imgDisplay.source = role.icon;
			}
			else
				imgDisplay.source = null;
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			imgDisplay.width = width;
			imgDisplay.height = height;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			graphics.clear();
			graphics.beginFill(0x0000ff,0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		/**
		 * 运行脚本动作
		 */		
		public function doAction():void
		{
			for each(var action:Action in actions)
			{
				action.coco::doAction(this, null);
			}
		}
		
	}
}
package com.xiaomu.renderer
{
	import com.xiaomu.data.Role;
	
	import coco.component.Image;
	import coco.component.ItemRenderer;
	import coco.component.Label;
	
	public class RoleItemRenderer extends ItemRenderer
	{
		public function RoleItemRenderer()
		{
			super();
		}
		
		private var iconDisplay:Image;
		private var nameDisplay:Label;
		
		override public function set data(value:Object):void
		{
			if (super.data == value) return;
			
			super.data = value;
			role = data as Role;
		}
		
		
		private var _role:Role;
		
		public function get role():Role
		{
			return _role;
		}
		
		public function set role(value:Role):void
		{
			if (_role == value) return;
			_role = value;
			invalidateProperties();
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			iconDisplay = new Image();
			iconDisplay.width = iconDisplay.height = 100;
			addChild(iconDisplay);
			
			nameDisplay = new Label();
			nameDisplay.height = 50;
			nameDisplay.fontSize = 15;
			addChild(nameDisplay);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (role)
			{
				iconDisplay.source = role.icon;
				nameDisplay.text = role.name;
			}
			else
			{
				iconDisplay.source = null;
				nameDisplay.text = null;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			iconDisplay.x = (width - iconDisplay.width) / 2;
			iconDisplay.y = (height - nameDisplay.height - iconDisplay.height) / 2;
			
			nameDisplay.width = width;
			nameDisplay.y = height - nameDisplay.height;
		}
		
		override protected function drawSkin():void
		{
			graphics.clear();
			
			graphics.beginFill(0xF2F0EB);
			graphics.drawRoundRectComplex(0, 0, width, height, 5, 5, 5, 5);
			graphics.endFill();
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawRoundRectComplex(0, height - 50, width, 50, 0, 0, 5, 5);
			graphics.endFill();
		}
		
	}
}
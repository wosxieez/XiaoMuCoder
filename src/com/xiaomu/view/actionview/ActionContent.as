package com.xiaomu.view.actionview
{
	import com.xiaomu.manager.ActionComponentManager;
	
	import coco.component.SkinComponent;
	
	public class ActionContent extends SkinComponent
	{
		public function ActionContent()
		{
			super();
			
			borderAlpha = backgroundAlpha = 1;
			borderColor = 0xF0E7CC;
			backgroundColor = 0xFEFBF0;
			ActionComponentManager.getInstance().init(this);
		}
		
		//----------------------------------------------------------------------------------------------------------------
		//
		// Methods
		//
		//----------------------------------------------------------------------------------------------------------------
		
		
	}
}
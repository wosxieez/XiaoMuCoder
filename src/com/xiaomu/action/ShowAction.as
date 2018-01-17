package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	public class ShowAction extends Action
	{
		public function ShowAction()
		{
			super();
		}
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			actionTarget.visible = true;
			endAction();
		}		
	}
}
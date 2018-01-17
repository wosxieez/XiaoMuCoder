package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	public class HiddenAction extends Action
	{
		public function HiddenAction()
		{
			super();
		}
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			actionTarget.visible = false;
			endAction();
		}

	}
}
package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.manager.RoleManager;
	import com.xiaomu.view.stageview.RoleComponent;
	
	public class AddDialogAction extends Action
	{
		public function AddDialogAction()
		{
			super();
		}
		
		override protected function onAction(actionTarget:RoleComponent):void
		{
			RoleManager.getInstance().addDialog(actionTarget.role);
			endAction();
		}

	}
}
package
{
	import com.xiaomu.component.AppAlert;
	import com.xiaomu.component.AppLoading;
	import com.xiaomu.event.LoginEvent;
	import com.xiaomu.event.VersionEvent;
	import com.xiaomu.manager.LoginManager;
	import com.xiaomu.manager.TipManager;
	import com.xiaomu.manager.VersionManager;
	import com.xiaomu.view.actionview.ActionView;
	import com.xiaomu.view.appView.XiaoMuCreate;
	import com.xiaomu.view.appView.XiaomuApp;
	import com.xiaomu.view.headview.Headview;
	import com.xiaomu.view.menuview.MenuView;
	import com.xiaomu.view.roleview.RoleView;
	import com.xiaomu.view.stageview.StageView;
	
	import flash.display.Screen;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import coco.component.Alert;
	import coco.core.Application;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;

	
	/**
	 * XiaoMuCoder Application 
	 * 小木编程
	 * @author coco
	 */	
	[SWF(width="1024", height="740")]
	public class XiaoMuCoder extends Application
	{
		public function XiaoMuCoder()
		{
			super();
			
			trace();
			
			autoDrawSkin = true;
			borderAlpha = backgroundAlpha = 0;
			TipManager.getInstance().init(this); // TIP管理器启动
			addEventListener(Event.ADDED_TO_STAGE, this_addedToStageHandler);
			LoginManager.getInstance().addEventListener(LoginEvent.ENTER_APP,enterApp_Handler);
		}
		
		private var appLoading:AppLoading;
		private var appView : XiaomuApp;
		private var xiaomuCreate:XiaoMuCreate;
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			appView = new XiaomuApp();

			xiaomuCreate = new XiaoMuCreate();
			addChild(xiaomuCreate);
			
			// 500毫秒后开始检查版本更新
			setTimeout(checkAppVersion, 500);
		}
		
		protected function enterApp_Handler(event:LoginEvent):void
		{
			if (appView.isPopUp) return;
			
			PopUpManager.addPopUp(appView);
			removeChild(xiaomuCreate);
			
		}			
		
		protected function this_addedToStageHandler(event:Event):void
		{
			// 程序居中代码
			stage.nativeWindow.x = Screen.mainScreen.visibleBounds.x + 
				(Screen.mainScreen.visibleBounds.width - stage.stageWidth) / 2;
			stage.nativeWindow.y = Screen.mainScreen.visibleBounds.y +
				(Screen.mainScreen.visibleBounds.height - stage.stageHeight) / 2;
		}
		
		
		/**
		 * 检查程序版本更新
		 */		
		private function checkAppVersion():void
		{
			VersionManager.getInstance().addEventListener(VersionEvent.CHECK_RESULT, version_checkResultHandler);
			VersionManager.getInstance().checkVersion();
		}
		
		protected function version_checkResultHandler(event:VersionEvent):void
		{
			if (event.available)
			{
				AppAlert.show(
					"最新版本:" + VersionManager.getInstance().latestVersionLabel +
					"\r当前版本:" + VersionManager.getInstance().curVersionLabel + 
					"\r\r发现新版应用程序，是否立即更新", 
					"版本提示", 
					Alert.OK|Alert.CANCEL, 
					null, 
					versionCloseHandler);
			}
		}
		
		private function versionCloseHandler(e:UIEvent):void
		{
			if (e.detail == Alert.OK)
			{
				appLoading = new AppLoading();
				PopUpManager.addPopUp(appLoading, null, true);
				PopUpManager.centerPopUp(appLoading);
				
				VersionManager.getInstance().addEventListener(VersionEvent.PROGRESS, version_processHandler);
				VersionManager.getInstance().addEventListener(VersionEvent.DOWNLOAD_RESULT, version_downloadResultHandler);
				VersionManager.getInstance().download();
			}
		}
		
		protected function version_processHandler(event:VersionEvent):void
		{
			appLoading.value = event.progressValue / 100;
		}
		
		protected function version_downloadResultHandler(event:VersionEvent):void
		{
			// 新版本下载完毕， 开始安装更新
			VersionManager.getInstance().install();
		}
		
	}
}
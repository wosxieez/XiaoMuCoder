package com.xiaomu.view.roleview
{
	import com.xiaomu.component.BarButton;
	import com.xiaomu.component.NoticePanel;
	import com.xiaomu.component.StatusButton;
	import com.xiaomu.data.Role;
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.RoleManager;
	import com.xiaomu.renderer.ShowListRenderer;
	import com.xiaomu.renderer.ShowMusicItemRender;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import coco.component.List;
	import coco.component.Panel;
	import coco.component.VerticalAlign;
	import coco.event.UIEvent;
	import coco.manager.PopUpManager;
	
	public class RoleSettingPanel extends Panel
	{
		public function RoleSettingPanel()
		{
			super();
			width = 330;
			height =500;
			titleHeight = 0;
			autoDrawSkin = false;
			RoleManager.getInstance().addEventListener(RoleEvent.SET_ROLE,this_Handler);
			RoleManager.getInstance().addEventListener(RoleEvent.DELETE_ROLESKIN,deleteRoleSkin_Handler);
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_ROLESKIN,addRoleSkin_Handler);
			RoleManager.getInstance().addEventListener(RoleEvent.ADD_BACKGROUNDMUSIC,addBgMusic_Handler);
			RoleManager.getInstance().addEventListener(RoleEvent.REMOVE_BACKGROUNDMUSIC,removeBgMusic_Handler);
			// 设置面板View <---> Role（数据）
		}

		//单例
		private static var instance : RoleSettingPanel;
		
		public static function getInstance():RoleSettingPanel
		{
			if(!instance)
				instance = new RoleSettingPanel();
			
			return instance;
		}
		
		private var statusButton1 : StatusButton;
		private var statusButton2 : StatusButton;
		private var statusButton3 : StatusButton;
		private var barButton1 : BarButton;
		private var barButton2 : BarButton;
		private var barButton3 : BarButton;
		private var barButton4 : BarButton;
		private var barButton5 : BarButton;
		private var barButton7 : BarButton;
		private var barButton8 : BarButton;
//		private var statusButton1_click : Boolean = false;
//		private var statusButton2_click : Boolean = false;
//		private var statusButton3_click : Boolean = false;
		private var noticePanel : NoticePanel;
		private var showMusicList : List;
		private var showList : List;
		
		// 设置面板数据都方在一个地方Role里面
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
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			statusButton1 = new  StatusButton();
			statusButton1.width = width/3-8;
			statusButton1.label = "造型";
			statusButton1.select = true;
			statusButton1.addEventListener(MouseEvent.CLICK,sB1_clickHandler);
			addChild(statusButton1);
			
			statusButton2 = new StatusButton();
			statusButton2.width = width/3-8;
			statusButton2.label = "声音";
			statusButton2.select = false;
			statusButton2.addEventListener(MouseEvent.CLICK,sB2_clickHandler);
			addChild(statusButton2);
			
			statusButton3 = new StatusButton();
			statusButton3.width = width/3-8;
			statusButton3.label = "数据";
			statusButton3.select = false;
			statusButton3.addEventListener(MouseEvent.CLICK,sB3_clickHandler);
			addChild(statusButton3);
			
			barButton1 = new BarButton();
			barButton1.labtext= "添加素材";
			barButton1.width =280;
			barButton1.source = "assets/add.png";
			barButton1.addEventListener(MouseEvent.CLICK , bB1_clickHandler);
			addChild(barButton1);
			barButton1.visible = true;
			
			
			barButton2 = new BarButton();
			barButton2.labtext = "自己绘画";
			barButton2.width = 230;
			barButton2.source = "assets/draw.png";
			addChild(barButton2);
			barButton2.visible = true;
			
			barButton3 = new BarButton(); // 上传按钮
			barButton3.width = 40;
			barButton3.source = "assets/upLoad.png";
			addChild(barButton3)
			barButton3.visible = true;
			
			barButton4 = new BarButton();
			barButton4.labtext = "添加声音";
			barButton4.width = 280;
			barButton4.source = "assets/add.png";
			barButton4.addEventListener(MouseEvent.CLICK,addMusicHandle);
			addChild(barButton4);
			barButton4.visible = false;
			
			barButton5 = new BarButton();
			barButton5.labtext = "我要录音";
			barButton5.width = 230;
			barButton5.source = "assets/audio.png";
			addChild(barButton5);
			barButton5.visible = false;
			
			barButton7 = new BarButton();
			barButton7.labtext = "新建变量";
			barButton7.width = 280;
			barButton7.source ="assets/add.png";
			addChild(barButton7);
			barButton7.visible = false;
			
			barButton8 = new BarButton();
			barButton8.labtext = "新建列表";
			barButton8.width = 280;
			barButton8.source = "assets/add.png";
			addChild(barButton8);
			barButton8.visible = false;
			
			showList = new List();
			showList.width = barButton1.width;
			showList.height = 330;
			showList.gap = 5;
			showList.itemRendererHeight = 60;
			showList.verticalAlign = VerticalAlign.TOP;
			showList.addEventListener(UIEvent.CHANGE,showList_changeHandler);
			addChild(showList);
			showList.visible = true;
			
//			showMusicList = new List();
//			showMusicList.width = barButton1.width;
//			showMusicList.height = 330;
//			showMusicList.gap = 5;
//			showMusicList.itemRendererHeight = 60;
//			showMusicList.itemRendererClass = ShowListRenderer;
//			showMusicList.verticalAlign = VerticalAlign.TOP;
////			showMusicList.addEventListener(UIEvent.CHANGE,showList_changeHandler);
//			addChild(showMusicList);
//			showMusicList.visible = true;
		}
		
		
		
		protected function showList_changeHandler(event:UIEvent):void
		{
			var itemselected:Object = showList.selectedItem;
			showList.selectedIndex = -1;
			
			var item_selectEvent : RoleEvent = new RoleEvent(RoleEvent.SELECT_SHOWLIST);
			RoleManager.getInstance().dispatchEvent(item_selectEvent);
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (!role) return;
			
			if(statusButton1.select)
			{
				showList.dataProvider = role.skin;
				showList.itemRendererClass = ShowListRenderer;
				showList.labelField = "name";
				barButton1.visible = barButton2.visible = barButton3.visible = true;
				barButton4.visible = barButton5.visible = barButton7.visible = barButton8.visible=false;
			}
			if(statusButton2.select)
			{
				showList.dataProvider = bgArr;
				showList.itemRendererClass = ShowMusicItemRender;
//				showList.dataProvider = role.skin;
				barButton4.visible = barButton5.visible = barButton3.visible = true;
				barButton1.visible = barButton2.visible = barButton7.visible = barButton8.visible=false;
			}
			if(statusButton3.select)
			{
				showList.dataProvider = null;
				showList.itemRendererClass = ShowListRenderer;
				barButton1.visible = barButton2.visible = barButton3.visible 
					=barButton4.visible = barButton5.visible= false;
				barButton7.visible = barButton8.visible = true;
			}
			
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			statusButton1.x = 12;
			statusButton2.x = statusButton1.x+statusButton1.width;
			statusButton3.x = statusButton2.x+statusButton2.width;
			statusButton1.y = statusButton2.y = statusButton3.y =12;
			
			barButton1.x = barButton4.x= barButton7.x =  (statusButton1.width*3 - barButton1.width)/2 + 12;
			barButton1.y = barButton4.y = barButton7.y = 60;
			
			barButton2.x = barButton5.x= barButton8.x =  (statusButton1.width*3 - barButton1.width)/2 + 12;
			barButton2.y = barButton5.y = barButton8.y = barButton3.y= 100;
			
			barButton3.x = barButton2.x+barButton2.width + 10;
			
			showList.x = barButton1.x;
			showList.y = 150;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			graphics.clear();
			graphics.lineStyle(1,0xF2E7C9);
			graphics.beginFill(0xFFFBF0);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
			
			graphics.beginFill(0xFAF4E4);
			graphics.drawRoundRect(11,statusButton1.y-1,width-23,height-2*statusButton1.y,4,4);
			graphics.endFill();
		}
		
		private var bgArr:Array=[];
		protected function addBgMusic_Handler(event:RoleEvent):void
		{
				if (event.role&&event.role.bgSource)
				{
					var bgrole:Role;
					bgrole = new Role();
					bgrole.name =event.role.name;
					bgrole.source = event.role.icon;	
					bgrole.bgSource = event.role.bgSource;
					bgArr.push(bgrole);	
					
					invalidateProperties();
					trace("添加背景音乐: "+event.role.bgSource);
				}
		}
		
		protected function addRoleSkin_Handler(event:RoleEvent):void
		{
			try
			{
				if (event.role&&event.role.skin.length>0)
				{
					var tempLength:int;  //数组的上一回的长度
					
					for(var index : int = event.role.skin.length-1; index>=tempLength; index--) //反向赋值
					{
						role.skin.unshift(event.role.skin[index]);
					}
					tempLength = event.role.skin.length;
					invalidateProperties();
					trace("已经执行");
					RoleManager.getInstance().removeRole(event.role);
				}
			} 
			catch(error:Error) 
			{
				trace("该角色没有皮肤");
				RoleManager.getInstance().removeRole(event.role);
			}
		}
		
		protected function deleteRoleSkin_Handler(event:RoleEvent):void
		{
			if(role.skin.length>1)
			{
				trace("RoleSettingPanel接收到属性失效命令");
				//在此出接受到 list 列表中的 选择的索引
				trace("showListIndex  :  "+event.index);
				role.skin.splice(event.index,1);
				invalidateProperties();
			}
			else
			{
				if(!noticePanel)
					noticePanel =new NoticePanel();
				
				PopUpManager.addPopUp(noticePanel,null,false,false);
				PopUpManager.centerPopUp(noticePanel);
				setTimeout(closeNoticePanel,2000);
			}
		}
		
		
		protected function removeBgMusic_Handler(event:RoleEvent):void
		{
			if(bgArr.length > 0)
			{
				trace("有可删除的背景音乐");
				trace("deleteListIndex  :  "+event.index);
				bgArr.splice(event.index,1);
				invalidateProperties();
				
				
			}
		}
		
		
		private function closeNoticePanel():void
		{
			PopUpManager.removePopUp(noticePanel);
		}
		
		protected function this_Handler(event:RoleEvent):void
		{
			role = event.role;
		}
		
		protected function bB1_clickHandler(event:MouseEvent):void
		{
			RoleManager.getInstance().addRoleCollection();
		}
		
		protected function addMusicHandle(event:MouseEvent):void
		{
			if(!RoleManager.getInstance().addRoleCollection())
			{
				trace("点击添加音乐按钮");
				RoleManager.getInstance().addRoleCollection();
			}
		}
		
		protected function sB3_clickHandler(event:MouseEvent):void
		{
			trace("点了3");
			statusButton1.select = statusButton2.select = false;
			invalidateProperties();
			
//			statusButton3_click = true;//stautsButton3 按钮已经被点击了
		}
		
		protected function sB2_clickHandler(event:MouseEvent):void
		{
			trace("点了2");
			
			statusButton1.select = statusButton3.select = false;
			invalidateProperties();
//			showList.itemRendererClass = ShowMusicItemRender;
//			statusButton2_click = true;//stautsButton2 按钮已经被点击了
		}
		
		protected function sB1_clickHandler(event:MouseEvent):void
		{
			trace("点了1");
			statusButton2.select = statusButton3.select = false;
			invalidateProperties();
			
//			statusButton1_click = true; //stautsButton1 按钮已经被点击了
		}
	}
}
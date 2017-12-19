package com.xiaomu.renderer
{
	import com.xiaomu.event.RoleEvent;
	import com.xiaomu.manager.RoleManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import coco.component.DefaultItemRenderer;
	import coco.component.Image;
	import coco.component.TextAlign;
	
	public class ShowMusicItemRender extends DefaultItemRenderer
	{
		public function ShowMusicItemRender()
		{
			super();
			mouseChildren = true;
			buttonMode = true;
			autoDrawSkin = false;
			addEventListener(MouseEvent.ROLL_OVER, this_rollOverHandler);
			addEventListener(MouseEvent.CLICK, this_clickHandler);
			addEventListener(MouseEvent.ROLL_OUT, this_rollOutHandler);
			RoleManager.getInstance().addEventListener(RoleEvent.SELECT_SHOWLIST,itemSelectedHandle);
		}
		
		protected function this_clickHandler(event:MouseEvent):void
		{
			
			selected = !selected;
			event.stopPropagation();
			
			if(selected){
				var s:Sound = new Sound();
				var req:URLRequest = new URLRequest(currentMusic);
				s.addEventListener(Event.COMPLETE, onSoundLoaded);
				trace("播放当前的背景音乐"+currentMusic);
				
				s.load(req);
			}
			
			else{
				return ;
			}
		}
		
		private var skinIcon : Image;
		private var closeIcon : Image;
		private var musicStart:Image;
		private var currentMusic:String;
		
		private var _mouseOver:Boolean = false;
		//		private var mouseOver:Boolean = false;
		private var selected:Boolean = false;
		
		
		protected function itemSelectedHandle(event:RoleEvent):void
		{	
			selected = mouseOver;
			invalidateProperties();
			invalidateSkin();
		}		
		
		private var oldsound:Sound;
		protected function onSoundLoaded(event:Event):void
		{
//			if(!oldsound)
//			{
				var localSound:Sound = event.target as Sound;
//			}
			
			
			localSound.play(0,4);
			trace("现在播放的是"+localSound);
			
		}
		
		
		public function get mouseOver():Boolean
		{
			return _mouseOver;
		}
		
		public function set mouseOver(value:Boolean):void
		{
			_mouseOver = value;
			invalidateSkin();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			labelDisplay.fontSize=15;
			labelDisplay.fontFamily = "Microsoft YaHei";
			labelDisplay.x = 80;
			labelDisplay.textAlign = TextAlign.LEFT;
			labelDisplay.color = 0x837664;
			
			skinIcon = new Image();
			skinIcon.height = skinIcon.width = 40;
			addChild(skinIcon);
			
			musicStart = new Image();
			//			musicStart.height =30;
			musicStart.source ="assets/musicstart.png";
			addChild(musicStart)
			
			closeIcon = new Image();
			closeIcon.height = closeIcon.width = 30;
			closeIcon.source ="assets/close3.png";
			closeIcon.addEventListener(MouseEvent.CLICK,closeIcon_clickHandler);
			addChild(closeIcon);
		}
		
		
		override protected function commitProperties():void
		{
			super.commitProperties();
	
			if(selected)
			{
				musicStart.source ="assets/musicstop.png";
			}
			else
			{
				musicStart.source ="assets/musicstart.png";
				
			}
			
			if (data)
			{
				labelDisplay.text = data.name;
				skinIcon.source = data.source;
				currentMusic = data.bgSource;
			}
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			skinIcon.x = 20;
			skinIcon.y = 10;
			
			musicStart.x = 180;
			musicStart.y = 20;
			
			closeIcon.x = 220;
			closeIcon.y = 16;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			graphics.clear();
			graphics.lineStyle(1, mouseOver ? 0x60A1F0 : 0xF2E7C9);
			
			if (mouseOver)
			{
				if(!selected)
				{
					graphics.beginFill(0xD7F3FD,0.8);
					
				}
				else
				{
					graphics.beginFill(0xD7F3FD,1);
				}
				graphics.lineStyle(1, 0x60A1F0);
			}				
			else
			{
				if(selected)
				{
					graphics.beginFill(0xD7F3FD,1);
					graphics.lineStyle(1, 0x60A1F0);
				}
				else
				{
					graphics.beginFill(0xD7F3FD,0);
					graphics.lineStyle(1, 0xF2E7C9);
				}
			}		
			//			graphics.beginFill(0xD7F3FD,mouseOver ? 1 : 0);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
			
		}
		
		protected function closeIcon_clickHandler(event:MouseEvent):void
		{
			trace("closeIcon侦听到点击");
			trace("渲染器中点击的是 ： "+index);
			event.stopPropagation();
		}
		
		protected function this_rollOutHandler(event:MouseEvent):void
		{
			mouseOver = false;
		}
		
		protected function this_rollOverHandler(event:MouseEvent):void
		{
			mouseOver = true;
		}
	}
}
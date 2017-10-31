package com.xiaomu.component
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	import coco.core.UIComponent;
	
	public class PicIconbtn extends UIComponent
	{
		public function PicIconbtn()
		{
			super();
		}
		
		private var loader01:Loader;
		
		public var _source:String;
		
		public  function get source():String
		{
			return _source;
		}
		
		public function set source (url : String):void
		{
			_source = url;
			invalidateProperties();
		}
		
		private var _radius:Number;
		
		public  function get radius():Number
		{
			return _radius;
		}
		
		public function set radius(value : Number):void
		{
			_radius = value;
		}
		
		private var _bitmap: Bitmap;
		
		public function get bitmap():Bitmap
		{
			return _bitmap;
		}
		
		public function set bitmap(value:Bitmap):void
		{
			_bitmap = value;
			invalidateSkin();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (source)
			{
				loader01 = new Loader();
				loader01.contentLoaderInfo.addEventListener(Event.COMPLETE,LoadercompleteHandle);//准备工作完成，实例化并且监听事件
				loader01.load(new URLRequest(source));	//开始加载图片
			}
		}
		
		protected function LoadercompleteHandle(event:Event):void
		{
			bitmap = event.currentTarget.content;
		}
		
		override protected function drawSkin():void
		{
			super.drawSkin();
			
			if (bitmap)
			{
				var matrix:Matrix = new Matrix();
				matrix.scale(2 * radius / bitmap.bitmapData.width, 2 * radius / bitmap.bitmapData.height);
				graphics.beginBitmapFill(bitmap.bitmapData, matrix);
				graphics.drawCircle(radius,radius,radius);
				graphics.endFill();
			}
			
		}
	}
}
package com.xiaomu.view.stageview {
	import com.xiaomu.util.AppUtil;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import coco.core.UIComponent;
	
	/**
	 * 变形器
	 * @author coco
	 *
	 */
	public class Transformer extends UIComponent {
		public function Transformer() {
			visible = false;
			addEventListener(MouseEvent.MOUSE_DOWN, this_mouseDownHandler);
		}
		
		
		private var radius:Number = 5;
		/**
		 * 0:zoom
		 * 1:move
		 * 2:rotate
		 * */
		private var type:int;
		private var centerPoint:Point;  // 中心点
		private var helperPoint:Point;  // 辅助点
		
		private var _target:UIComponent;
		
		/**
		 * 变形的对象
		 * @return
		 */
		public function get target():UIComponent {
			return _target;
		}
		
		public function set target(value:UIComponent):void {
			_target = value;
			
			if (target) {
				visible = true;
				
				width = target.width;
				height = target.height;
				x = target.x;
				y = target.y;
				rotation = target.rotation;
				
				if (parent)
					parent.setChildIndex(this, parent.numChildren - 1);
			}
			else {
				visible = false;
			}
		}
		
		override public function set visible(value:Boolean):void {
			super.visible = value
			mouseEnabled = visible
		}
		
		
		override protected function measure():void {
			measuredHeight = measuredWidth = 100;
		}
		
		override protected function updateDisplayList():void {
			super.updateDisplayList();
			
			if (target) {
				target.width = width;
				target.height = height;
				target.x = x;
				target.y = y;
				target.rotation = rotation;
			}
		}
		
		override protected function drawSkin():void {
			graphics.clear();
			graphics.lineStyle(2, 0xE5E5E5);
			graphics.beginFill(0xFF0000, .0);
			graphics.drawRect(0, 0, width, height);
			graphics.moveTo(width / 2, 0);
			graphics.lineTo(width / 2, -20);
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(width / 2, -20, radius);
			graphics.drawRect(-radius, -radius, 2 * radius, 2 * radius);
			graphics.drawRect(width - radius, -radius, 2 * radius, 2 * radius);
			graphics.drawRect(width - radius, height - radius, 2 * radius, 2 * radius);
			graphics.drawRect(-radius, height - radius, 2 * radius, 2 * radius);
			graphics.endFill();
		}
		
		protected function this_mouseDownHandler(event:MouseEvent):void {
			centerPoint = localToGlobal(new Point(width / 2, height / 2));
			if (-radius <= mouseX && mouseX <= radius) {
				if (-radius <= mouseY && mouseY <= radius) {
					// left top point
					type = 0;
					helperPoint = localToGlobal(new Point(0, 0));
				}
				else {
					// left bottom point
					type = 0;
					helperPoint = localToGlobal(new Point(0, height));
				}
			}
			else if (width - radius <= mouseX && mouseX <= width + radius) {
				if (-radius <= mouseY && mouseY <= radius) {
					// right top point
					type = 0;
					helperPoint = localToGlobal(new Point(width, 0));
				}
				else {
					// right bottom point
					type = 0;
					helperPoint = localToGlobal(new Point(width, height));
				}
			}
			else {
				// rotate point or down move
				if (mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height) {
					type = 1;
				}
				else {
					type = 2;
				}
				helperPoint = new Point(stage.mouseX, stage.mouseY);
			}
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		
		protected function stage_mouseMoveHandler(event:MouseEvent):void {
			switch (type) {
				case 0:  // zoom
				{
					zoom();
					event.updateAfterEvent();
					break;
				}
				case 1:  // move
				{
					move();
					event.updateAfterEvent();
					break;
				}
				case 2:  // rotate
				{
//					rotate();
//					event.updateAfterEvent();
					break;
				}
				default: {
					break;
				}
			}
		}
		
		protected function stage_mouseUpHandler(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		
		private function zoom():void {
			var newPoint:Point = AppUtil.getInstance().getMouseZoomAxisPoint(centerPoint,
					helperPoint,
					new Point(stage.mouseX, stage.mouseY));
			width = Math.abs(newPoint.x - centerPoint.x) * 2;
			height = Math.abs(newPoint.y - centerPoint.y) * 2;
			newPoint.x = centerPoint.x - width / 2;
			newPoint.y = centerPoint.y - height / 2;
			newPoint = parent.globalToLocal(newPoint);
			x = newPoint.x;
			y = newPoint.y;
			invalidateDisplayList();
		}
		
		private function move():void {
			var newPoint:Point = new Point(stage.mouseX, stage.mouseY);
			newPoint.x = newPoint.x - helperPoint.x;
			newPoint.y = newPoint.y - helperPoint.y;
			newPoint.x = centerPoint.x + newPoint.x - width / 2;
			newPoint.y = centerPoint.y + newPoint.y - height / 2;
			newPoint = parent.globalToLocal(newPoint);
			x = newPoint.x;
			y = newPoint.y;
			invalidateDisplayList();
		}
		
		private var ro:Number = 0;
		
		private function rotate():void {
			var a:Number = (stage.mouseX - centerPoint.x);
			var b:Number = (stage.mouseY - centerPoint.y);
			var angle:Number;
			if (a >= 0 && b <= 0) {
				angle = Math.atan(-a / b);
			}
			else if (a >= 0 && b >= 0) {
				angle = Math.PI - Math.atan(a / b);
			}
			else if (a <= 0 && b >= 0) {
				angle = Math.PI + Math.atan(-a / b);
			}
			else {
				angle = 2 * Math.PI - Math.atan(a / b);
			}
			
			var dc:Number = angle - ro;
			ro = angle;
			
			var matrix1:Matrix = transform.matrix;
			matrix1.translate(-(this.width / 2 + this.x), -(this.height / 2 + this.y));  //平移
			matrix1.rotate(dc);
			matrix1.translate((this.width / 2 + this.x), (this.height / 2 + this.y));
			transform.matrix = matrix1;
		}
		
	}
}
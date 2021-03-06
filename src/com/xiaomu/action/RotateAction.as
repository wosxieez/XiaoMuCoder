package com.xiaomu.action
{
	import com.xiaomu.data.Action;
	import com.xiaomu.view.stageview.RoleComponent;
	
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class RotateAction extends Action
	{
		public function RotateAction()
		{
			super();	
		}		
		
		override protected function onAction(actionTarget:RoleComponent):void
		{			
			centerRotate(actionTarget,actionTarget.rotation+30);
			endAction();
		}
		
		public function centerRotate(target:DisplayObject,angle:Number):void   
		{         
			var currentRotation:Number = target.rotation;  
			//获取target不旋转时候的尺寸  
			target.rotation = 0;  
			var targetWidth:Number = target.width;  
			var targetHeight:Number = target.height;  
			target.rotation = currentRotation;  
			
			//获取target当前中心点坐标  
			var pointO:Point = target.localToGlobal(new Point(targetWidth / 2, targetHeight / 2));  
			
			//旋转target
			target.rotation = angle;  
			
			//获取target旋转后中心点坐标  
			var pointO2:Point = target.localToGlobal(new Point(targetWidth / 2, targetHeight / 2));  
			//平移到原来中心点O  
			var p3:Point = pointO.subtract(pointO2);  
			var matrix:Matrix = target.transform.matrix;  
			matrix.translate(p3.x, p3.y);  
			
			target.transform.matrix = matrix;  
		}  
		
	}
}
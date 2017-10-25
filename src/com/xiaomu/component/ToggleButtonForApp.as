/**
 * Created by coco on 17/03/2017.
 */
package com.xiaomu.component
{
    import coco.component.Image;
    import coco.component.ToggleButton;

    public class ToggleButtonForApp extends ToggleButton
    {
        public function ToggleButtonForApp()
        {
            super();
        }

        override protected function measure():void
        {
            var defaultWidth:Number = 68;
            var defaultHeight:Number = 21;

            // width or height isNaN
            if (labelDisplay)
            {
                defaultWidth = Math.max(defaultWidth, labelDisplay.width + 30);
                defaultHeight = Math.max(defaultHeight, labelDisplay.height + 10);
            }

            measuredWidth = defaultWidth;
            measuredHeight = defaultHeight;
        }

        override protected function updateDisplayList():void
        {
            super.updateDisplayList();

            labelDisplay.x = 20;
			labelDisplay.y = -4;
            labelDisplay.setmeasuredSizeWithoutDispatchResizeEvent(width - 20, height);
        }

        override protected function drawSkin():void
        {
            var icon:Image = new Image();
			icon.width = 24;
			icon.height = 24;
			icon.y = 2;
			
            if (selected)
			{
				icon.source = "assets/selected.png";
			}
			else
			{
				icon.source = "assets/unselected.png";
			}
			addChild(icon);

        }

    }
}

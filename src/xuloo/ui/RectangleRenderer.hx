package xuloo.ui;

import flash.display.Graphics;
import flash.geom.Rectangle;

public class RectangleRenderer implements IShapeRenderer
{
	public function new() {
	}
	
	public function render(surface:Graphics, rect:Rectangle):Void {
		surface.drawRect(rect.x, rect.y, rect.width, rect.height);
	}
}
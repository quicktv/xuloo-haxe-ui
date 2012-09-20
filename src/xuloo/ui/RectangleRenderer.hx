package xuloo.ui;

import flash.display.Graphics;
import flash.geom.Rectangle;

class RectangleRenderer implements IShapeRenderer
{
	public function new() {
	}
	
	public function render(surface:Graphics, rect:Rectangle):Void {
		Console.log("rendering rectangle: " + rect);
		surface.drawRect(rect.x, rect.y, rect.width, rect.height);
	}
}
package xuloo.ui;

import nme.display.Graphics;
import nme.geom.Rectangle;

class RectangleRenderer implements IShapeRenderer
{
	public function new() {
	}
	
	public function render(surface:Graphics, rect:Rectangle):Void {
		surface.drawRect(rect.x, rect.y, rect.width, rect.height);
	}
}
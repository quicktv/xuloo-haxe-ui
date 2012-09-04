package xuloo.ui;

import flash.display.Graphics;
import flash.geom.Rectangle;

class EllipseRenderer implements IShapeRenderer {
	
	public function new() {
	}
	
	public function render(surface:Graphics, rect:Rectangle):Void {
		surface.drawEllipse(rect.x, rect.y, rect.width, rect.height);
	}
}
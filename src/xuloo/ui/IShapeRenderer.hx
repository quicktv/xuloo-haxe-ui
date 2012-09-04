package xuloo.ui;

import flash.display.Graphics;
import flash.geom.Rectangle;

interface IShapeRenderer {
	function render(surface:Graphics, rect:Rectangle):Void;
}
package xuloo.ui;

import nme.display.Graphics;
import nme.geom.Point;
import nme.geom.Rectangle;

class SpeechBubbleRenderer implements IShapeRenderer {
	
	var cornerRadius(default, default):Float;
	
	var point(default, default):Point;
	
	public function new(cornerRadius:Float, point:Point) {
		this.cornerRadius = cornerRadius;
		this.point = point;
	}
	
	public function render(surface:Graphics, rect:Rectangle):Void {
		drawBubble(surface, rect, cornerRadius, point);
	}
	
	public function drawBubble(surface:Graphics, rect:Rectangle, cornerRadius:Float, point:Point):Void {
		var rad:Float = cornerRadius;
		var x:Float = rect.x;
		var y:Float = rect.y;
		var w:Float = rect.width;
		var h:Float = rect.height;
		var px:Float = point.x;
		var py:Float = point.y;
		var min_gap:Float = 20;
		var hgap:Float = Math.min(w - rad - rad, Math.max(min_gap, w / 5));
		var left:Float = px <= x + w / 2 ? 
			(Math.max(x+rad, px))
			:(Math.min(x + w - rad - hgap, px - hgap));
		var right:Float = px <= x + w / 2?
			(Math.max(x + rad + hgap, px+hgap))
			:(Math.min(x + w - rad, px));
		var vgap:Float = Math.min(h - rad - rad, Math.max(min_gap, h / 5));
		var top:Float = py < y + h / 2 ?
			Math.max(y + rad, py)
			:Math.min(y + h - rad - vgap, py-vgap);
		var bottom:Float = py < y + h / 2 ?
			Math.max(y + rad + vgap, py+vgap)
			:Math.min(y + h - rad, py);
		
		//bottom right cornernsd
		var a:Float = rad - (rad*0.707106781186547);
		var s:Float = rad - (rad*0.414213562373095);
		
		surface.moveTo ( x+w,y+h-rad);
		if (rad > 0)
		{
			if (px > x+w-rad && py > y+h-rad && Math.abs((px - x - w) - (py - y - h)) <= rad)
			{
				surface.lineTo(px, py);
				surface.lineTo(x + w - rad, y + h);
			}
			else
			{
				surface.curveTo( x + w, y + h - s, x + w - a, y + h - a);
				surface.curveTo( x + w - s, y + h, x + w - rad, y + h);
			}
		}
		
		if (py > y + h && (px - x - w) < (py - y -h - rad) && (py - y - h - rad) > (x - px))
		{
			// bottom edge
			surface.lineTo(right, y + h);
			surface.lineTo(px, py);
			surface.lineTo(left, y + h);
		}
		
		surface.lineTo ( x+rad,y+h );
		
		//bottom left corner
		if (rad > 0)
		{
			if (px < x + rad && py > y + h - rad && Math.abs((px-x)+(py-y-h)) <= rad)
			{
				surface.lineTo(px, py);
				surface.lineTo(x, y + h - rad);
			}
			else
			{
				surface.curveTo( x+s,y+h,x+a,y+h-a);
				surface.curveTo( x, y + h - s, x, y + h - rad);
			}
		}
		
		if (px < x && (py - y - h + rad) < (x - px) && (px - x) < (py - y - rad) )
		{
			// left edge
			surface.lineTo(x, bottom);
			surface.lineTo(px, py);
			surface.lineTo(x, top);
		}
		
		surface.lineTo ( x,y+rad );
		
		//top left corner
		if (rad > 0)
		{
			if (px < x + rad && py < y + rad && Math.abs((px - x) - (py - y)) <= rad)
			{
				surface.lineTo(px, py);
				surface.lineTo(x + rad, y);
			}
			else
			{
				surface.curveTo( x,y+s,x+a,y+a);
				surface.curveTo( x + s, y, x + rad, y);
			}
		}
		
		if (py < y && (px - x) > (py - y + rad) && (py - y + rad) < (x - px + w))
		{
			//top edge
			surface.lineTo(left, y);
			surface.lineTo(px, py);
			surface.lineTo(right, y);
		}
		
		surface.lineTo ( x + w - rad, y );
		
		//top right corner
		if (rad > 0)
		{
			if (px > x + w - rad && py < y + rad && Math.abs((px - x - w) + (py - y)) <= rad)
			{
				surface.lineTo(px, py);
				surface.lineTo(x + w, y + rad);
			}
			else
			{
				surface.curveTo( x+w-s,y,x+w-a,y+a);
				surface.curveTo( x + w, y + s, x + w, y + rad);
			}
		}
		
		if (px > x + w && (py - y - rad) > (x - px + w) && (px - x - w) > (py - y - h + rad) )
		{
			// right edge
			surface.lineTo(x + w, top);
			surface.lineTo(px, py);
			surface.lineTo(x + w, bottom);
		}
		surface.lineTo ( x+w,y+h-rad );
		
	}
}
package xuloo.ui;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

class BasicShape extends UIComponent
{
	var _renderer:IShapeRenderer;
	
	public var backgroundSprite(getBackgroundSprite, never):Sprite;
	
	var _backgroundSprite:Sprite;
	public function getBackgroundSprite():Sprite {
		return _backgroundSprite;
	}
	
	public var borderSprite(getBorderSprite, never):Sprite;
	
	var _borderSprite:Sprite;
	public function getBorderSprite():Sprite {
		return _borderSprite;
	}
	
	var _w:Float;	
	public override function setWidth(value:Float):Float {
		super.setWidth(_w =  value);

		render();

		return _w;
	}
	
	var _h:Float;	
	public override function setHeight(value:Float):Float {
		super.setHeight(_h = value);

		render();

		return _h;
	}
	
	public var backgroundColour(getBackgroundColour, setBackgroundColour):Float;
			
	var _backgroundColour:Float;	
	public function getBackgroundColour():Float {
		return _backgroundColour;
	}	
	public function setBackgroundColour(value:Float):Float {
		_backgroundColour = value;	

		render();
		
		return _backgroundColour;
	}
	
	public var backgroundOpacity(getBackgroundOpacity, setBackgroundOpacity):Float;
	
	var _backgroundOpacity:Float;	
	public function getBackgroundOpacity():Float {
		return _backgroundOpacity;
	}	
	public function setBackgroundOpacity(value:Float):Float {
		_backgroundOpacity = _backgroundSprite.alpha = value;	
		
		return _backgroundOpacity;
	}
	
	public var borderColour(getBorderColour, setBorderColour):Float;
	
	var _borderColour:Float;	
	public function getBorderColour():Float {
		return _borderColour;
	}	
	public function setBorderColour(value:Float):Float {
		_borderColour = value;	

		Console.log("setting border colour " + value);
		
		render();
		
		return _borderColour;
	}
	
	public var borderThickness(getBorderThickness, setBorderThickness):Float;
	
	var _borderThickness:Float;	
	public function getBorderThickness():Float {
		return _borderThickness;
	}
	public function setBorderThickness(value:Float):Float {
		_borderThickness = value;

		render();
		
		return _borderThickness;
	}
	
	public var borderOpacity(getBorderOpacity, setBorderOpacity):Float;
	
	var _borderOpacity:Float;	
	public function getBorderOpacity():Float {
		return _borderOpacity;
	}
	public function setBorderOpacity(value:Float):Float {
		_borderOpacity = _borderSprite.alpha = value;
		
		return _borderOpacity;
	}
	
	public var shape(getShape, setShape):String;
	
	var _shape:String;	
	public function getShape():String {
		return _shape;
	}
	public function setShape(value:String):String {
		_shape = value;
		
		switch (_shape)
		{
			case "Circle":
				_renderer = new EllipseRenderer();
			
			case "Rectangle":
				_renderer = new RectangleRenderer();
			
			case "Speech Bubble":
				_renderer = new SpeechBubbleRenderer(5, new Point());
		}
		
		render();	
		
		return _shape;
	}
	
	public var cornerRadius(never, setCornerRadius):Float;
	
	public function setCornerRadius(value:Float):Float {
		_renderer = new SpeechBubbleRenderer(value, new Point());
		
		render();
		
		return value;
	}
	
	override function render():Void {	
		super.render();	
		drawBackgroundSprite();
		drawBorderSprite();
	}
	
	public function new() {
		super();
	}
	
	public override function initialize():Void {	
		_borderThickness = 0;
		_backgroundColour = 0xffffff;
		_borderColour = 0;
		
		_borderSprite = new Sprite();
		_borderSprite.name = "Border Sprite";
		_backgroundSprite = new Sprite();
		_backgroundSprite.name = "Background Sprite";
		
		shape = Constants.RECTANGLE;
		width = 200;
		height = 100;
		
		sprite.addChild(_borderSprite);
		sprite.addChild(_backgroundSprite);
	}
	
	public function drawBackgroundSprite():Void {
		var surface:Graphics = _backgroundSprite.graphics;
			
		surface.clear();
		surface.lineStyle();
		surface.beginFill(cast(_backgroundColour, Int));
		
		if (!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0) {
			_renderer.render(surface, new Rectangle(0, 0, _w, _h));
		}
		
		surface.endFill();
	}
	
	public function drawBorderSprite():Void {
		var surface:Graphics = _borderSprite.graphics;
		
		//Console.log("drawing a border of thickness " + _borderThickness + " of colour " + cast(_borderColour, Int));

		surface.clear();
		surface.lineStyle(_borderThickness, cast(_borderColour, Int));
		surface.beginFill(0, 0);
		
		if (!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0) {
			_renderer.render(surface, new Rectangle(1, 1, _w - 2, _h - 2));
		}
		
		surface.endFill();
	}
}
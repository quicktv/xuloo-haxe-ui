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
	
	public var innerBorderSprite(getInnerBorderSprite, never):Sprite;
	
	var _innerBorderSprite:Sprite;
	public function getInnerBorderSprite():Sprite {
		return _innerBorderSprite;
	}
	
	var _w:Float;	
	public override function setWidth(value:Float):Float {
		super.setWidth(_w =  value);

		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();

		return _w;
	}
	
	var _h:Float;	
	public override function setHeight(value:Float):Float {
		super.setHeight(_h = value);

		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();

		return _h;
	}
	
	public var backgroundColour(getBackgroundColour, setBackgroundColour):Float;
			
	var _backgroundColour:Float;	
	public function getBackgroundColour():Float {
		return _backgroundColour;
	}	
	public function setBackgroundColour(value:Float):Float {
		_backgroundColour = value;		
		Console.log("drawing background with colour " + value);
		drawBackgroundSprite();
		
		return _backgroundColour;
	}
	
	public var backgroundOpacity(getBackgroundOpacity, setBackgroundOpacity):Float;
	
	var _backgroundOpacity:Float;	
	public function getBackgroundOpacity():Float {
		return _backgroundOpacity;
	}	
	public function setBackgroundOpacity(value:Float):Float {
		_backgroundOpacity = value;
		_backgroundSprite.alpha = value;	
		
		return _backgroundOpacity;
	}
	
	public var borderColour(getBorderColour, setBorderColour):Int;
	
	var _borderColour:Int;	
	public function getBorderColour():Int {
		return _borderColour;
	}	
	public function setBorderColour(value:Int):Int {
		_borderColour = value;	
		
		drawInnerBorderSprite();
		drawBorderSprite();
		
		return _borderColour;
	}
	
	public var borderThickness(getBorderThickness, setBorderThickness):Float;
	
	var _borderThickness:Float;	
	public function getBorderThickness():Float {
		return _borderThickness;
	}
	public function setBorderThickness(value:Float):Float {
		_borderThickness = value;
		drawBorderSprite();
		drawInnerBorderSprite();
		return _borderThickness;
	}
	
	public var borderOpacity(getBorderOpacity, setBorderOpacity):Float;
	
	var _borderOpacity:Float;	
	public function getBorderOpacity():Float {
		return _borderOpacity;
	}
	public function setBorderOpacity(value:Float):Float {
		_borderOpacity = value;
		_borderSprite.alpha = value;
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
			
			//default:
				//throw new Error("There is no renderer for shape '" + _shape + "'");
		}
		
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
		//_borderSprite.alpha = value	
		
		return _shape;
	}
	
	public var cornerRadius(never, setCornerRadius):Float;
	
	public function setCornerRadius(value:Float):Float {
		_renderer = new SpeechBubbleRenderer(value, new Point());
		
		render();
		
		return value;
	}
	
	override function render():Void {		
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
	}
	
	public function new() {
		super();
	}
	
	public override function initialize():Void {	
		_borderThickness = 0;
		_backgroundColour = 0;
		
		_borderSprite = new Sprite();
		_borderSprite.name = "Border Sprite";
		_backgroundSprite = new Sprite();
		_backgroundSprite.name = "Background Sprite";
		_innerBorderSprite = new Sprite();
		_innerBorderSprite.name = "Inner Border Sprite";
		
		shape = Constants.RECTANGLE;
		width = 200;
		height = 100;
		
		#if flash
		_borderSprite.blendMode = flash.display.BlendMode.LAYER;
		_innerBorderSprite.blendMode = flash.display.BlendMode.ERASE;
		#end
		/*#elseif js
		//_borderSprite.blendMode = jeash.display.BlendMode.LAYER;
		//_innerBorderSprite.blendMode = jeash.display.BlendMode.ERASE;
		#end*/	
		
		//drawBackgroundSprite();
		//drawBorderSprite();
		//drawInnerBorderSprite();
		
		sprite.addChild(_backgroundSprite);
		sprite.addChild(_borderSprite);
		_borderSprite.addChild(_innerBorderSprite);
				
		//dispatchEvent(new Event(Event.COMPLETE));
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
		#if flash
		var surface:Graphics = _borderSprite.graphics;
		
		surface.clear();
		surface.lineStyle();
		surface.beginFill(_borderColour);
		
		if (!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0) {
			_renderer.render(surface, new Rectangle(0, 0, _w, _h));
		}
		
		surface.endFill();
		#end
	}
	
	public function drawInnerBorderSprite():Void {		
		#if flash	
		var surface:Graphics = _innerBorderSprite.graphics;
		
		surface.clear();
		surface.lineStyle();
		surface.beginFill(cast(_backgroundColour, Int));
		
		if (!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0)
		{
			_renderer.render(surface, new Rectangle(_borderThickness/2, _borderThickness/2, width - (_borderThickness), height - (_borderThickness)));
		}
		
		surface.endFill();
		#end
	}
}
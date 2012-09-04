package xuloo.ui;

import flash.display.BlendMode;
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
	
	var _borderSprite:Sprite = new Sprite();
	public function getBorderSprite():Sprite {
		return _borderSprite;
	}
	
	public var innerBorderSprite(getInnerBorderSprite, never):Sprite;
	
	var _innerBorderSprite:Sprite = new Sprite();
	public function getInnerBorderSprite():Sprite {
		return _innerBorderSprite;
	}
	
	var _w:Float = 0.0;	
	public override function setWidth(value:Float):Void {
		super.width = _w =  value;

		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();
	}
	
	var _h:Float = 0.0;	
	public override function setHeight(value:Float):Void {
		super.height = _h =  value;
		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();
	}
	
	public var backgroundColour(getBackgroundColour, setBackgroundColour):Int;
			
	var _backgroundColour:Int = 0xffffff;	
	public function getBackgroundColour():Int {
		return _backgroundColour;
	}	
	public function setBackgroundColour(value:Int):Void {
		_backgroundColour = value;		
		
		drawBackgroundSprite();
	}
	
	public var backgroundOpacity(getBackgroundOpacity, setBackgroundOpacity):Float;
	
	var _backgroundOpacity:Float;	
	public function getBackgroundOpacity():Float {
		return _backgroundOpacity;
	}	
	public function setBackgroundOpacity(value:Float):Void {
		_backgroundOpacity = value;
		_backgroundSprite.alpha = value;			
	}
	
	public var borderColour(getBorderColour, setBorderColour):Int;
	
	var _borderColour:Int;	
	public function getBorderColour():Int {
		return _borderColour;
	}	
	public function setBorderColour(value:Int):Void {
		_borderColour = value;	
		
		drawInnerBorderSprite();
		drawBorderSprite();
	}
	
	public var borderThickness(getBorderThickness, setBorderThickness):Float;
	
	var _borderThickness:Float;	
	public function getBorderThickness():Float {
		return _borderThickness;
	}
	public function setBorderThickness(value:Float):Void {
		_borderThickness = value;
		//drawBorderSprite()	
		drawInnerBorderSprite();
	}
	
	public var borderOpacity(getBorderOpacity, setBorderOpacity):Float;
	
	var _borderOpacity:Float;	
	public function getBorderOpacity():Float {
		return _borderOpacity;
	}
	public function setBorderOpacity(value:Float):Void {
		_borderOpacity = value;
		
		_borderSprite.alpha = value;		
	}
	
	public var shape(getShape, setShape):String;
	
	var _shape:String;	
	public function getShape():String {
		return _shape;
	}
	public function setShape(value:String):Void {
		_shape = value;
		
		switch (_shape)
		{
			case "Circle":
				_renderer = new EllipseRenderer();
				break;
			
			case "Rectangle":
				_renderer = new RectangleRenderer();
				break;
			
			case "Speech Bubble":
				_renderer = new SpeechBubbleRenderer(5, new Point());
				break;
			
			default:
				throw new Error("There is no renderer for shape '" + _shape + "'");
		}
		
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
		//_borderSprite.alpha = value			
	}
	
	public var cornerRadius(never, setCornerRadius):Float;
	
	public function setCornerRadius(value:Float):Void {
		_renderer = new SpeechBubbleRenderer(value, new Point());
		
		render();
	}
	
	private function render():Void {		
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
	}
	
	public function new() {
		super();
		
		initialise();
	}
	
	public function initialise():Void {	
		shape = Constants.RECTANGLE;
		width = 200;
		height = 100;
		
		_backgroundSprite = new Sprite();
		
		_borderSprite.blendMode = BlendMode.LAYER;
		_innerBorderSprite.blendMode = BlendMode.ERASE;			
		
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
		
		addChild(_backgroundSprite);
		addChild(_borderSprite);
		_borderSprite.addChild(_innerBorderSprite);
					
		//dispatchEvent(new Event(Event.COMPLETE));
	}
	
	public function drawBackgroundSprite():Void {
		var surface:Graphics = _backgroundSprite.graphics;
		
		surface.clear();
		surface.beginFill(_backgroundColour);
		
		if (!isNaN(_w) && _w > 0 && !isNaN(_h) && _h > 0) {
			_renderer.render(surface, new Rectangle(0, 0, _w, _h));
		}
		
		surface.endFill();
	}
	
	public function drawBorderSprite():Void {
		var surface:Graphics = _borderSprite.graphics;
		
		surface.clear();
		surface.beginFill(_borderColour);
		
		if (!isNaN(_w) && _w > 0 && !isNaN(_h) && _h > 0) {
			_renderer.render(surface, new Rectangle(0, 0, _w, _h));
		}
		
		surface.endFill();
	}
	
	public function drawInnerBorderSprite():Void {			
		var surface:Graphics = _innerBorderSprite.graphics;
		
		surface.clear();
		surface.beginFill(0xff0000);
		
		if (!isNaN(_w) && _w > 0 && !isNaN(_h) && _h > 0)
		{
			_renderer.render(surface, new Rectangle(_borderThickness/2, _borderThickness/2, width - (_borderThickness), height - (_borderThickness)));
		}
		
		surface.endFill();
		
	}
}
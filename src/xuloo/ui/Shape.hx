package xuloo.ui;

import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.GetLogger;
import qtv.api.core.Constants;
import qtv.impl.component.display.DisplayComponent;

class BasicShape extends UIComponent {
	public var backgroundSprite(getBackgroundSprite, never) : Sprite;
	public var borderSprite(getBorderSprite, never) : Sprite;
	public var innerBorderSprite(getInnerBorderSprite, never) : Sprite;
	public var backgroundColour(getBackgroundColour, setBackgroundColour) : Int;
	public var backgroundOpacity(getBackgroundOpacity, setBackgroundOpacity) : Float;
	public var borderColour(getBorderColour, setBorderColour) : Int;
	public var borderThickness(getBorderThickness, setBorderThickness) : Float;
	public var borderOpacity(getBorderOpacity, setBorderOpacity) : Float;
	public var shape(getShape, setShape) : String;
	public var cornerRadius(never, setCornerRadius) : Float;

	var _renderer : IShapeRenderer;
	var _backgroundSprite : Sprite;
	public function getBackgroundSprite() : Sprite {
		return _backgroundSprite;
	}

	var _borderSprite : Sprite;
	public function getBorderSprite() : Sprite {
		return _borderSprite;
	}

	var _innerBorderSprite : Sprite;
	public function getInnerBorderSprite() : Sprite {
		return _innerBorderSprite;
	}

	var _w : Float;
	override public function setWidth(value : Float) : Float {
		super.width = _w = value;
		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();
		return value;
	}

	var _h : Float;
	override public function setHeight(value : Float) : Float {
		super.height = _h = value;
		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();
		return value;
	}

	var _backgroundColour : Int;
	public function getBackgroundColour() : Int {
		return _backgroundColour;
	}

	public function setBackgroundColour(value : Int) : Int {
		_backgroundColour = value;
		drawBackgroundSprite();
		return value;
	}

	var _backgroundOpacity : Float;
	public function getBackgroundOpacity() : Float {
		return _backgroundOpacity;
	}

	public function setBackgroundOpacity(value : Float) : Float {
		_backgroundOpacity = value;
		_backgroundSprite.alpha = value;
		return value;
	}

	var _borderColour : Int;
	public function getBorderColour() : Int {
		return _borderColour;
	}

	public function setBorderColour(value : Int) : Int {
		_borderColour = value;
		drawInnerBorderSprite();
		drawBorderSprite();
		return value;
	}

	var _borderThickness : Float;
	public function getBorderThickness() : Float {
		return _borderThickness;
	}

	public function setBorderThickness(value : Float) : Float {
		_borderThickness = value;
		//drawBorderSprite()
		drawInnerBorderSprite();
		return value;
	}

	var _borderOpacity : Float;
	public function getBorderOpacity() : Float {
		return _borderOpacity;
	}

	public function setBorderOpacity(value : Float) : Float {
		_borderOpacity = value;
		_borderSprite.alpha = value;
		return value;
	}

	var _shape : String;
	public function getShape() : String {
		return _shape;
	}

	public function setShape(value : String) : String {
		_shape = value;
		switch(_shape) {
		case "Circle":
			_renderer = new EllipseRenderer();
		case "Rectangle":
			_renderer = new RectangleRenderer();
		case "Speech Bubble":
			_renderer = new SpeechBubbleRenderer(5, new Point());
		default:
			throw new Error("There is no renderer for shape '" + _shape + "'");
		}
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
		//_borderSprite.alpha = value
		return value;
	}

	public function setCornerRadius(value : Float) : Float {
		_renderer = new SpeechBubbleRenderer(value, new Point());
		render();
		return value;
	}

	function render() : Void {
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
	}

	public function new() {
		_backgroundSprite = new Sprite();
		_borderSprite = new Sprite();
		_innerBorderSprite = new Sprite();
		_w = 0.0;
		_h = 0.0;
		_backgroundColour = 0xffffff;
		_borderThickness = 0;
		super();
		initialise();
	}

	public function initialise() : Void {
		shape = Constants.RECTANGLE;
		width = 200;
		height = 100;
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

	public function drawBackgroundSprite() : Void {
		var surface : Graphics = _backgroundSprite.graphics;
		surface.clear();
		surface.beginFill(_backgroundColour);
		if(!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0)  {
			_renderer.render(surface, new Rectangle(0, 0, _w, _h));
		}
		surface.endFill();
	}

	public function drawBorderSprite() : Void {
		var surface : Graphics = _borderSprite.graphics;
		surface.clear();
		surface.beginFill(_borderColour);
		if(!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0)  {
			_renderer.render(surface, new Rectangle(0, 0, _w, _h));
		}
		surface.endFill();
	}

	public function drawInnerBorderSprite() : Void {
		var surface : Graphics = _innerBorderSprite.graphics;
		surface.clear();
		surface.beginFill(0xff0000);
		if(!Math.isNaN(_w) && _w > 0 && !Math.isNaN(_h) && _h > 0)  {
			_renderer.render(surface, new Rectangle(_borderThickness / 2, _borderThickness / 2, width - (_borderThickness), height - (_borderThickness)));
		}
		surface.endFill();
	}

}
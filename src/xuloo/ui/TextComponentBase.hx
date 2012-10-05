package xuloo.ui;

import flash.display.BlendMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

class TextComponentBase extends UIComponent {
	public var backgroundSprite(getBackgroundSprite, never) : Sprite;
	public var borderSprite(getBorderSprite, never) : Sprite;
	public var innerBorderSprite(getInnerBorderSprite, never) : Sprite;
	public var textOpacity(getTextOpacity, setTextOpacity) : Float;
	public var font(getFont, setFont) : String;
	public var size(getSize, setSize) : Float;
	public var align(getAlign, setAlign) : String;
	public var bold(getBold, setBold) : Bool;
	public var italic(getItalic, setItalic) : Bool;
	public var underline(getUnderline, setUnderline) : Bool;
	public var backgroundColour(getBackgroundColour, setBackgroundColour) : Int;
	public var backgroundOpacity(getBackgroundOpacity, setBackgroundOpacity) : Float;
	public var borderColour(getBorderColour, setBorderColour) : Int;
	public var borderThickness(getBorderThickness, setBorderThickness) : Float;
	public var borderOpacity(getBorderOpacity, setBorderOpacity) : Float;
	public var textField(getTextField, never) : TextField;
	public var text(getText, setText) : String;
	public var colour(getColour, setColour) : Int;

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

	override public function setWidth(value : Float) : Float {
		super.setWidth(value);
		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();
		if(_textField != null) _textField.width = value;
		return value;
	}

	override public function setHeight(value : Float) : Float {
		super.setHeight(value);
		drawBackgroundSprite();
		drawInnerBorderSprite();
		drawBorderSprite();
		if(_textField != null) _textField.height = value;
		return value;
	}

	var _textOpacity : Float;
	public function getTextOpacity() : Float {
		return _textOpacity;
	}

	public function setTextOpacity(value : Float) : Float {
		_textOpacity = value;
		_textField.alpha = textOpacity;
		return value;
	}

	var _font : String;
	public function getFont() : String {
		return _font;
	}

	public function setFont(value : String) : String {
		_font = value;
		//invalidateTextFormat();
		return value;
	}

	var _size : Float;
	public function getSize() : Float {
		return _size;
	}

	public function setSize(value : Float) : Float {
		_size = value;
		//invalidateTextFormat();
		return value;
	}

	var _align : String;
	public function getAlign() : String {
		return _align;
	}

	public function setAlign(value : String) : String {
		_align = value;
		//invalidateTextFormat();
		return value;
	}

	var _bold : Bool;
	public function getBold() : Bool {
		return _bold;
	}

	public function setBold(value : Bool) : Bool {
		_bold = value;
		//invalidateTextFormat();
		return value;
	}

	var _italic : Bool;
	public function getItalic() : Bool {
		return _italic;
	}

	public function setItalic(value : Bool) : Bool {
		_italic = value;
		//invalidateTextFormat();
		return value;
	}

	var _underline : Bool;
	public function getUnderline() : Bool {
		return _underline;
	}

	public function setUnderline(value : Bool) : Bool {
		_underline = value;
		//invalidateTextFormat();
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

	var _textField : TextField;
	public function getTextField() : TextField {
		return _textField;
	}

	var _textKey : String;
	public function getText() : String {
		return _textField.htmlText;
	}

	public function setText(value : String) : String {
		doSetText(value);

		return value;
	}

	function doSetText(value : Dynamic) : Void {
		_textField.htmlText = StringTools.urlDecode(value);
	}

	var _colour : Int;
	public function getColour() : Int {
		return _colour;
	}

	public function setColour(value : Int) : Int {
		_colour = value;
		//invalidateTextFormat();
		return value;
	}

	public function new() {
		_backgroundSprite = new Sprite();
		_borderSprite = new Sprite();
		_innerBorderSprite = new Sprite();
		_font = "Helvetica";
		_size = 16;
		_align = "left";
		_backgroundColour = 0xffffff;
		_borderThickness = 0;
		_colour = 0x0;
		super();
		initialise();
	}

	public function initialise() : Void {
		_textField = new TextField();
		_textField.multiline = true;
		_textField.wordWrap = true;
		_textField.selectable = false;
		//_textField.styleSheet = new StyleSheet();
		//width = _textField.width = 200;
		//height = _textField.height = 100;
		_borderSprite.blendMode = BlendMode.LAYER;
		_innerBorderSprite.blendMode = BlendMode.ERASE;
		drawBackgroundSprite();
		drawBorderSprite();
		drawInnerBorderSprite();
		sprite.addChild(_backgroundSprite);
		sprite.addChild(_borderSprite);
		_borderSprite.addChild(_innerBorderSprite);
		sprite.addChild(_textField);
		//dispatchEvent(new Event(Event.COMPLETE));
	}

	public function invalidateTextFormat() : Void {
		/*var tf : TextFormat = new TextFormat();
            tf.font = font;
            tf.size = size;
            tf.bold = bold;
            tf.underline = underline;
            tf.italic = italic;
            tf.color = colour;
            tf.align = align;

            _textField.setTextFormat( _textField.defaultTextFormat = tf );*/
	}

	public function drawBackgroundSprite() : Void {
		_backgroundSprite.graphics.clear();
		_backgroundSprite.graphics.beginFill(_backgroundColour);
		_backgroundSprite.graphics.drawRect(0, 0, width, height);
		_backgroundSprite.graphics.endFill();
	}

	public function drawBorderSprite() : Void {
		_borderSprite.graphics.clear();
		_borderSprite.graphics.beginFill(_borderColour);
		_borderSprite.graphics.drawRect(0, 0, width, height);
		_borderSprite.graphics.endFill();
	}

	public function drawInnerBorderSprite(value : Bool = true) : Void {
		if(value)  {
			_innerBorderSprite.graphics.clear();
			_innerBorderSprite.graphics.beginFill(0xff0000);
			_innerBorderSprite.graphics.drawRect(_borderThickness / 2, _borderThickness / 2, width - (_borderThickness), height - (_borderThickness));
			_innerBorderSprite.graphics.endFill();
		}
		_textField.width = width - (borderThickness);
		_textField.height = height - (borderThickness);
		_textField.x = borderThickness / 2;
		_textField.y = borderThickness / 2;
	}

}


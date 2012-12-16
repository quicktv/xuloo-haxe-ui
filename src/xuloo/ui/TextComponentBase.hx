package xuloo.ui;

import flash.display.BlendMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

class TextComponentBase extends UIComponent {

	var _shape:BasicShape;

	public var textOpacity(getTextOpacity, setTextOpacity) : Float;
	public var font(getFont, setFont) : String;
	public var size(getSize, setSize) : Float;
	public var align(getAlign, setAlign) : String;
	public var bold(getBold, setBold) : Bool;
	public var italic(getItalic, setItalic) : Bool;
	public var underline(getUnderline, setUnderline) : Bool;
	public var backgroundColour(getBackgroundColour, setBackgroundColour) : Float;
	public var backgroundOpacity(getBackgroundOpacity, setBackgroundOpacity) : Float;
	public var borderColour(getBorderColour, setBorderColour) : Float;
	public var borderThickness(getBorderThickness, setBorderThickness) : Float;
	public var borderOpacity(getBorderOpacity, setBorderOpacity) : Float;
	public var textField(getTextField, never) : TextField;
	public var text(getText, setText) : String;
	public var colour(getColour, setColour) : Int;

	override public function setAlpha(value:Float):Float { 
		_shape.alpha = value;
		return super.setAlpha(value); 
	}

	override public function setWidth(value : Float) : Float {
		super.setWidth(value);
		_shape.width = value;
		if(_textField != null) _textField.width = value;
		return value;
	}

	override public function setHeight(value : Float) : Float {
		super.setHeight(value);
		_shape.height = value;
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

	public function getBackgroundColour() : Float {
		return _shape.backgroundColour;
	}

	public function setBackgroundColour(value : Float) : Float {
		return _shape.backgroundColour = value;
	}

	public function getBackgroundOpacity() : Float {
		return _shape.backgroundOpacity;
	}

	public function setBackgroundOpacity(value : Float) : Float {
		return _shape.backgroundOpacity = value;
	}

	public function getBorderColour() : Float {
		return _shape.borderColour;
	}

	public function setBorderColour(value : Float) : Float {
		return _shape.borderColour = value;
	}

	public function getBorderThickness() : Float {
		return _shape.borderThickness;
	}

	public function setBorderThickness(value : Float) : Float {
		return _shape.borderThickness = value;
	}

	public function getBorderOpacity() : Float {
		return _shape.borderOpacity;
	}

	public function setBorderOpacity(value : Float) : Float {
		return _shape.borderOpacity = value;
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
		super();

		addChild(_shape = new BasicShape());
	}

	public function initialise() : Void {
		_textField = new TextField();
		_textField.multiline = true;
		_textField.wordWrap = true;
		_textField.selectable = false;
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

}


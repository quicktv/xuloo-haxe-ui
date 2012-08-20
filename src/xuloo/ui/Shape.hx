package xuloo.ui;
import xuloo.util.NumberUtils;

/**
 * ...
 * @author Trevor B
 */

class Shape extends UIComponent
{
	public var borderColor(never, setBorderColor):Int;
	
	var _borderColor:Int;
	public function setBorderColor(value:Int):Int {
		_borderColor = value;
		#if js
		Console.log("border color " + jquery + " " + NumberUtils.dec2hex(value));
		jquery.css("border-color", "#00ff00");
		#end
		return _borderColor;
	}
	
	public var borderWidth(never, setBorderWidth):Float;
	
	var _borderWidth:Float;
	public function setBorderWidth(value:Float):Float {
		_borderWidth = value;
		#if js
		jquery.css("border-width", Std.string(_borderWidth) + "px");
		#end
		return _borderWidth;
	}
	
	public var backgroundColor(never, setBackgroundColor):Int;
	
	var _backgroundColor:Int;
	public function setBackgroundColor(value:Int):Int {
		_backgroundColor = value;
		#if js
		Console.log("background color jquery " + jquery + " " + NumberUtils.dec2hex(value));
		jquery.css("background", "#ffcc00");
		#end
		return _backgroundColor;
	}
	
	public function new() {
		super();
	}
	
	override function initialize()
	{
		super.initialize();
		#if js
		jquery.css("background-repeat", "no-repeat");
		jquery.css("background-position", "initial");
		#end
	}
}
package xuloo.ui;

#if flash
import flash.display.Sprite;
#elseif js
import js.Lib;
import js.Dom;
#end

/**
 * ...
 * @author Trevor B
 */

class TextField extends UIComponent
{
	var textNode:HtmlDom;
	
	public var text(getText, setText):String;
	
	var _text:String;
	public function getText():String {
		return _text;
	}
	public function setText(value:String):String {
		_text = value;
		return _text;
	}
	
	public function new() {
		super();
	}
	
	override function initialize()
	{
		#if flash
		super.initialize();
		#elseif js
		super.initialize();
		textNode = js.Lib.document.createTextNode("hello, this is the original text");
		//textNode.setAttribute("id", id);
		textNode.className = className;
		//textNode.style.position = "relative";
		element.appendChild(textNode);
		#end
	}
	
}
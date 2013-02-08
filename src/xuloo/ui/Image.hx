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

class Image extends UIComponent
{
	var image:HtmlDom;
	
	public var src(getSource, setSource):String;
	
	var _src:String;
	function getSource():String {
		return _src;
	}
	function setSource(source:String):String {
		_src = source;
		#if js
		image.setAttribute("src", _src);
		#end
		return _src;
	}
	
	public override function setWidth(value:Float):Float {
		super.setWidth(value);
		#if js
		image.setAttribute("width", Std.string(_width) + "px");
		#end
		return _width;
	}
	
	public override function setHeight(value:Float):Float {
		super.setHeight(value);
		#if js
		image.setAttribute("height", Std.string(_height) + "px");
		#end
		return _height;
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
		image = js.Lib.document.createElement("img");
		image.setAttribute("id", id);
		image.className = className;
		image.style.position = "relative";
		image.onresize = onResize;
		
		element.appendChild(image);
		#end
	}
	
	private function onResize(e:Event) {
		#if preview Console.log("on resize"); #end
	}
}
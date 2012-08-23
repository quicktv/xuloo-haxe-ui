package xuloo.ui;

#if js
import js.Dom;
import js.JQuery;
import js.Lib;
#end
/**
 * ...
 * @author Trevor B
 */

class KalturaVideo extends UIComponent
{
	public var video(default, default):HtmlDom;

	public var source(never, setSource):Dynamic;
	
	var _source:Dynamic;
	public function setSource(value:Dynamic):Dynamic {
		return _source = value;
	}
	
	public override function setHeight(value:Float):Float {
		super.setHeight(value);
		
		#if js
		video.setAttribute("height", Std.string(value));
		#end
		
		return _height;
	}
	
	public override function setWidth(value:Float):Float {
		super.setWidth(value);
		
		#if js
		video.setAttribute("width", Std.string(value));
		#end
		
		return _width;
	}
	
	var elementRewritten:Bool;
	
	public function new() {
		super();
	}
	
	override function onTick(value:Float):Void {
		if (!elementRewritten) {
			var query:JQuery = new JQuery(".mv-player");
			if (query.size() > 0) {
				elementRewritten = true;
				query.css("z-index", "0");
			}
		}
	}
	
	override function initialize()
	{
		#if flash
		super.initialize();
		#elseif js
		super.initialize();
		
		if (tagName == null) tagName = "video";
		video = js.Lib.document.createElement("video");
		
		video.setAttribute("poster", "http://cdn.kaltura.org/apis/html5lib/kplayer-examples/media/bbb480.jpg");
		video.setAttribute("durationHint", "33");
		
		var script = Lib.document.createElement("script");
		script.setAttribute("type", "text/javascript");
		script.setAttribute("src", "http://html5.kaltura.org/js");
		Lib.document.body.appendChild(script);
		
		var source = Lib.document.createElement("source");
		source.setAttribute("type", "video/webm");
		source.setAttribute("src", "http://cdn.kaltura.org/apis/html5lib/kplayer-examples/media/bbb_trailer_360p.webm?a"); 
		video.appendChild(source);
		
		source = Lib.document.createElement("source");
		source.setAttribute("src", "http://cdn.kaltura.org/apis/html5lib/kplayer-examples/media/bbb_trailer_iphone270P.m4v"); 
		video.appendChild(source);
		
		source = Lib.document.createElement("source");
		source.setAttribute("src", "http://cdn.kaltura.org/apis/html5lib/kplayer-examples/media/bbb_trailer_400p.ogv"); 
		video.appendChild(source);
		
		element.appendChild(video);
		
		element.onresize = onResize;

		#end
	}
	
	function onResize(e:Event):Void {
		Console.log("resizing");
	}
}
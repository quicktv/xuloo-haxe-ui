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
		var video = js.Lib.document.createElement("video");
		
		video.setAttribute("width", "480");
		video.setAttribute("height", "267");
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
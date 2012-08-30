package xuloo.ui;

import qtv.api.VideoModel;
import qtv.api.KalturaClientProperties;

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
	
	var _source:VideoModel;
	public function setSource(value:VideoModel):VideoModel {
		_source = value;
		createSources();
		return _source;
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
	
	function createSources():Void {
	
		var props:KalturaClientProperties = new KalturaClientProperties(_source.ovpAccount);
		
		video.setAttribute("width", Std.string(_source.width));
		video.setAttribute("height", Std.string(_source.height));
		video.setAttribute("poster", "http://cdn.kaltura.com/p/" + props.partnerId + "/thumbnail/entry_id/" + _source.videoId + "/width/" + Std.string(_source.width) + "/height/" + Std.string(_source.height));
		video.setAttribute("controls", "");
		
		for (version in _source.versions) {
			if (version.format == "mp4") {
				var source = Lib.document.createElement("source");
				source.setAttribute("src", "http://cdnbakmi.kaltura.com/p/" + props.partnerId + "/sp/" + props.partnerId + "00/playManifest/entryId/" + _source.videoId + "/flavorId/" + version.versionId + "/format/url/protocol/http/a." + version.format); 
		
				video.appendChild(source);
			}
		}	
	}
	
	override function initialize()
	{
		#if flash
		super.initialize();
		#elseif js
		super.initialize();
		video = js.Lib.document.createElement("video");
		element.appendChild(video);
		element.onresize = onResize;
		#end
	}
	
	function onResize(e:Event):Void {
		Console.log("resizing");
	}
}
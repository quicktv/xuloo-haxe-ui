package xuloo.ui;

import qtv.api.VideoModel;
import qtv.api.KalturaClientProperties;

#if js
import js.Dom;
import js.JQuery;
import js.Lib;
#elseif flash
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
#end

/**
 * ...
 * @author Trevor B
 */

class KalturaVideo extends UIComponent
{
	#if js
	public var video(default, default):HtmlDom;
	#elseif flash
	public var video(default, default):IVideo;
	public var player(default, default):IVideoPlayer;
	public var aspectRatio(default, default):Float;
	#end

	public var source(never, setSource):VideoModel;
	
	var _source:VideoModel;
	public function setSource(value:VideoModel):VideoModel {
		_source = value;
		
		#if js
		createSources();
		#elseif flash
		if (player) {
			sprite.removeChild(cast(player, DisplayObject));	
		}
		
		video = cast(_source, IVideo);
		
		var playerUrl:String = context.releaseBucket + "/qtv-flex-interactive-video-player-" + _video.ovp.shortKey + "-" + context.versions.getValue(Versions.QTV_INTERACTIVE_VIDEO_PLAYER_VERSION) + ".swf";
		
		aspectRatio = video.width / video.height;
		
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
		_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		_loader.load(new URLRequest(playerUrl));
		#end
		
		return _source;
	}
	
	#if flash
	function onLoadComplete(e:Event):void 
	{
		try {
			var clazz:Class = Class(_loader.contentLoaderInfo.applicationDomain.getDefinition("qtv.ivp.player.VideoPlayer"));
			player = cast(new clazz, IVideoPlayer);

			addChildAt(cast(player, DisplayObject), 1);
			
			player.video = source;
			player.init();
			
			if (player.isReady)
			{
				onPlayerReady();
			}
			else
			{
				player.ready.add(onPlayerReady);
			}
		
		} catch (err:Error) {

		}
	}

	function onPlayerReady():void 
	{
		updateVideoDimensions();
		
		dispatchEvent(new Event(Event.COMPLETE));
		_isReady = true;
		ready.dispatch();
	}
	
	function onLoadError(e:IOErrorEvent):void 
	{

	}
	
	function updateVideoDimensions():void 
	{
		/*CONFIG::debug {
			logger.debug("updating video dimensions {0}", [_player]);
		}*/
		
		if (player)
		{
			var videoDisplay:DisplayObject = cast(player, DisplayObject);
			var myAspect:Number = _w / _h;
			
			/*CONFIG::debug {
				logger.debug("updating video dimensions {0} {1} {2} {3} {4} {5}", [myAspect, _aspectRatio, _w, _h, _video.width, _video.height]);
			}*/
			
			var playerWidth:Number = 0.0;
			var playerHeight:Number = 0.0;
			
			if (myAspect < _aspectRatio)
			{
				playerWidth = _w;
				playerHeight = _w / _aspectRatio;
				
				/*CONFIG::debug {
					logger.debug("_player.width={0} _player.height={1}", [_w, (_w / _aspectRatio)]);
				}*/
			}
			else
			{
				playerHeight = _h;
				playerWidth = _h * _aspectRatio;
				
				/*CONFIG::debug {
					logger.debug("_player.width={0} _player.height={1}", [(_h * _aspectRatio), _h]);
				}*/
			}
			
			/*CONFIG::debug {
				logger.debug("player x={0} y={1} width={2} height={3} _player.width={4} _player.height={5}", [videoDisplay.x, videoDisplay.y, playerWidth, playerHeight, videoDisplay.width, videoDisplay.height]);
			}*/
			
			videoDisplay.x = (_w - playerWidth) / 2;
			videoDisplay.y = (_h - playerHeight) / 2;

			videoDisplay.width = playerWidth;
			videoDisplay.height = playerHeight;
			
			/*CONFIG::debug {
				logger.debug("player x={0} y={1} width={2} height={3} _player.width={4} _player.height={5}", [videoDisplay.x, videoDisplay.y, playerWidth, playerHeight, videoDisplay.width, videoDisplay.height]);
			}*/
		}
	}
	#end
	
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
		#if preview Console.log("resizing"); #end
	}
}
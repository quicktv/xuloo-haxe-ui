package xuloo.ui;

import qtv.impl.core.VideoModel;
import xuloo.ui.IVideoPlayer;

#if flash
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
#end

class BasicVideo extends BasicShape {
	public var player(getPlayer, setPlayer) : IVideoPlayer;
	public var source(getSource, setSource) : VideoModel;

	#if flash 
	var _loader : Loader;
	#end
	
	var _player : IVideoPlayer;
	public function getPlayer() : IVideoPlayer {
		return _player;
	}
	public function setPlayer(value:IVideoPlayer) : IVideoPlayer {
		_player = value;
		_sprite.addChildAt(cast(_player, DisplayObject), 1);
		return _player;
	}

	var _aspectRatio : Float;
	
	var _video : VideoModel;
	
	override public function setWidth(value : Float) : Float {
		super.setWidth(value);
		updateVideoDimensions();
		return value;
	}

	override public function setHeight(value : Float) : Float {
		super.setHeight(value);
		updateVideoDimensions();
		return value;
	}

	override public function getShape() : String {
		return "Rectangle";
	}

	public function new() {
		super();
		
		_aspectRatio = 1;
	}

	var _source : VideoModel;
	var _sourceKey : Dynamic;
	/**
	 * To get current source ,path of image
	 */
	public function getSource() : Dynamic {
		return _source;
	}

	/**
	 * To set current source and it load the image into loader
	 */
	public function setSource(value : VideoModel) : VideoModel {
		Console.log("setting source for the video to " + value + " " + _player);
		
		_aspectRatio = value.width / value.height;
		_player.video = _source = value;
		_player.init();
		if (_player.isReady)  {
			Console.log("video is already ready");
			onPlayerReady();
		} else {
			Console.log("video not ready - adding a listener");
			_player.ready.add(onPlayerReady);
		}
		
		visible = true;
		alpha = 1;

		return value;
	}

	override public function initialize() : Void {
		super.initialize();
		backgroundColour = 0x000000;
	}

	#if flash
	function onPlayerReady() : Void {
		updateVideoDimensions();
		dispatchEvent(new Event(Event.COMPLETE));
		_isReady = true;
		ready.dispatch();
	}
	#end

	function updateVideoDimensions() : Void {

		if(_player != null)  {
			var videoDisplay : DisplayObject = cast(_player, DisplayObject);
			var myAspect : Float = _w / _h;

			var playerWidth : Float = 0.0;
			var playerHeight : Float = 0.0;
			if(myAspect < _aspectRatio)  {
				playerWidth = _w;
				playerHeight = _w / _aspectRatio;
			} else {
				playerHeight = _h;
				playerWidth = _h * _aspectRatio;
			}
			
			Console.log(_w + " " + _h + " " + _aspectRatio + " " + playerWidth + " " + playerHeight);

			videoDisplay.x = (_w - playerWidth) / 2;
			videoDisplay.y = (_h - playerHeight) / 2;
			videoDisplay.width = playerWidth;
			videoDisplay.height = playerHeight;
		}
	}

	///////////////////////////////////////////////////////////////////////
	// VIDEO PLAYER IMPLEMENTATION                                       //
	///////////////////////////////////////////////////////////////////////
	public function play() : Void {
		if(_player != null) _player.play();
	}

	public function pause() : Void {
		if(_player != null) _player.pause();
	}

	public function seek(value : Int) : Void {
		if(_player != null) _player.playheadTime = value;
	}

}


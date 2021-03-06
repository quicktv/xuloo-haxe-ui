package xuloo.ui;

import qtv.impl.core.VideoModel;
import xuloo.ui.IVideoPlayer;

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

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
		_sprite.addChild(cast(_player, DisplayObject));
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
		_aspectRatio = value.width / value.height;
		_player.video = _source = value;
		_player.init();

		if (_player.isReady)  {
			#if preview Console.log("video is already ready"); #end
			onPlayerReady();
		} else {
			#if preview Console.log("video not ready - adding a listener"); #end
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

	function onPlayerReady() : Void {
		updateVideoDimensions();
		dispatchEvent(new Event(Event.COMPLETE));
		_isReady = true;
		ready.dispatch();
	}

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
			
			#if preview Console.log(_player + " " + _w + " " + _h + " " + _aspectRatio + " " + playerWidth + " " + playerHeight); #end

			videoDisplay.x = (_w - playerWidth) / 2;
			videoDisplay.y = (_h - playerHeight) / 2;

			_player.setWidth(playerWidth);
			_player.setHeight(playerHeight);

			#if preview Console.log("resulting dimensions " + width + " " + height + " " + videoDisplay.width + " " + videoDisplay.height); #end
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


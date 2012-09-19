package xuloo.ui;

import flash.events.Event;

class VideoControlEvent extends Event {
	public static var PAUSE_VIDEO:String = "PauseVideo";
	public static var PLAY_VIDEO:String = "PlayVideo";
	public static var SEEK_VIDEO:String = "SeekVideo";
	public static var CHANGE_VIDEO:String = "ChangeVideo";
	
	public var time(getTime, never):Int;
	public var embedCode(getEmbedCode, never):String;
	
	var _time:Int;
	var _embedCode:String;
	
	public function getTime():Int {
		return _time;
	}
	
	public function getEmbedCode():String {
		return _embedCode;
	}
	
	public function new(type:String, time:Int = -1, bubbles:Bool=false, cancelable:Bool=false, embedCode:String=null) {
		super(type, bubbles, cancelable);
		
		_time = time;
		_embedCode = embedCode;
	}
}
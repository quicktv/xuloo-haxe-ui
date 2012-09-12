package xuloo.ui;

import nme.events.Event;

class OpenPopupEvent extends Event
{
	public static var OPEN_POPUP:String = "OpenPopup";
	
	public var url(getUrl, never):String;
	public var title(getTitle, never):String;
	public var specs(getSpecs, never):String;
	
	var _url:String;
	var _title:String;
	var _specs:String;
	
	public function getUrl():String {
		return _url;
	}
	
	public function getTitle():String {
		return _title;
	}
	
	public function getSpecs():String {
		return _specs;
	}
	
	public function new(type:String, url:String, title:String, specs:String) {
		super(type, bubbles, cancelable);
		
		_url = url;
		_title = title;
		_specs = specs;
	}
}
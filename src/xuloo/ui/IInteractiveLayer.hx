package xuloo.ui;

import flash.events.IEventDispatcher;

interface IInteractiveLayer implements IEventDispatcher
{
	var enabled(getEnabled, setEnabled):Bool;
	var playheadTime(getPlayheadTime, never):Int;
	var context(never, setContext):IComponentContext;
	var service(getService, never):IComponentService;
	var components(getComponents, never):Array<UIComponent>;
	
	function pauseVideo():Void;	
	function playVideo():Void;	
	function openPopup(url:String, title:String, specs:String):Void;	
	function seek(time:Int, redispatch:Bool):Void;	
	function getEnabled():Bool;
	function setEnabled(value:Bool):Void;	
	function track(url:String):Void;	
	function getPlayheadTime():Float;	
	function setContext(value:IComponentContext):Void;	
	function getService():IComponentService;	
	function getComponents():Array<UIComponent>;
}
package xuloo.ui;

import flash.events.IEventDispatcher;

interface IInteractiveLayer implements IEventDispatcher
{
	var enabled(getEnabled, setEnabled):Bool;
	var playheadTime(getPlayheadTime, never):Int;
	var componentContext(getComponentContext, setComponentContext):IComponentContext;
	var service(getService, never):IComponentService;
	var rootComponent(getRootComponent, never):UIComponent;
	
	function pauseVideo():Void;	
	function playVideo():Void;	
	function openPopup(url:String, title:String, specs:String):Void;	
	function seek(time:Int, redispatch:Bool):Void;	
	function getEnabled():Bool;
	function setEnabled(value:Bool):Bool;	
	function track(url:String):Void;	
	function getPlayheadTime():Int;	
	function getComponentContext():IComponentContext;
	function setComponentContext(value:IComponentContext):IComponentContext;	
	function getService():IComponentService;	
	function getRootComponent():UIComponent;
}
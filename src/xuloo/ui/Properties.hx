package xuloo.ui;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import msignal.Signal;

class Properties
{
	public var complete(getComplete, never):Signal1<Properties>;
	
	var _complete:Signal1<Properties>;	
	public function getComplete():Signal1<Properties>
	{
		return _complete = (_complete == null) ? new Signal1<Properties>() : _complete;
	}
	
	/**
	 * Dictionary object containing the key/value properties loaded from
	 * files or registered directly.
	 */
	private var _properties:Hash<Dynamic>;
	
	/**
	 * Seperator character used to split the key/value properties.
	 */
	private var _seperator:String;
	
	/**
	 * The list of properties files to be loaded and parsed.
	 */
	private var _files:Array<String>;
	
	/**
	 * Counter used to track how many properties files have been loaded and parsed during the 'load' operation.
	 */
	private var _loadCount:Int;
	
	/**
	 * Constructor.
	 * Optionally provide a seperator character that will be used to 
	 * split the key/value pairs in the properties files.
	 * Default is a newline '\n' chararacter.
	 */
	public function Properties(seperator:String = "\n")
	{
		_properties = new Hash<Dynamic>();
		_files = new Array<String>();
		_seperator = seperator;
	}
	
	/**
	 * Add a file url to the list of properties files to be loaded.
	 */
	public function addFile(url:String):Void 
	{
		_files.push(url);
	}
	
	/**
	 * Add an array of files to the list of properties files to be loaded.
	 */
	public function addFiles(files:Array<String>):Void 
	{
		_files = _files.concat(files);
	}
	
	/**
	 * Load the registered files.
	 * If there are no files to load dispatches 'complete' event immediately.
	 */
	public function load():Void 
	{
		_loadCount = _files.length;
		
		if (_loadCount > 0)
		{			
			for (url in _files)
			{
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				
				loader.load(new URLRequest(url + "?" + RandomUtils.randomString(10)));
			}
		}
		else
		{
			complete.dispatch(this);
		}
	}
	
	/**
	 * When properties file load has completed the file is parsed and the properties registered.
	 * Check to see if all files have loaded, if they have then dispatch 'complete' event.
	 */
	private function onLoadComplete(e:Event):Void 
	{
		var loader:URLLoader = cast(e.target, URLLoader);
		var properties:String = cast(loader.data, String);
		
		parseProperties(properties);
		
		_loadCount--;
		
		if (_loadCount == 0)
		{
			complete.dispatch(this);
		}
	}
	
	private function onLoadError(e:IOErrorEvent):Void 
	{
		
	}
	
	/**
	 * Parse the properties file, if the line isn't empty and isn't a comment
	 * (comment lines begin with a '#') then the line is split on the '='
	 * symbol and the resulting key/value pair is registered with the properties Dictionary.
	 */
	public function parseProperties(properties:String):Void 
	{
		var keyValueArray:Array<String> = properties.split(_seperator);
		
		for (keyValue in keyValueArray)
		{
			if (keyValue != null && keyValue.length > 0 && 
				keyValue.charAt(0) != "#" &&
				keyValue.charAt(0) != "")
			{
				var split:Array<String> = keyValue.split("=");
				setProperty(split[0], split[1]);
			}
		}
	}
	
	/**
	 * Register a key/value property value pair.
	 */
	public function setProperty(key:String, value:Dynamic):Void 
	{
		_properties.set(key, value);
	}
	
	/**
	 * Retrieve the raw value of the property key.
	 */
	public function getProperty(key:String):Dynamic
	{
		return _properties.get(key);
	}
	
	/**
	 * Retrieve a property value as a Number.
	 */
	public function getFloatProperty(key:String):Float 
	{
		return cast(_properties.get(key), Float);
	}
	
	/**
	 * Retrieve a property value as a String.
	 */
	public function getStringProperty(key:String):String 
	{
		return cast(_properties.get(key), String);
	}
}
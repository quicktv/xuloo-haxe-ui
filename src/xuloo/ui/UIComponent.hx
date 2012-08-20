/*
Copyright (c) 2012 Massive Interactive

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
*/

package xuloo.ui;

import js.Event;
import minject.Injector;

#if flash
import flash.display.Sprite;
#elseif js
import js.JQuery;
import js.Lib;
import js.Dom;
#end
import msignal.Signal;

/**
Simple implementation of a cross platform View class that composes a
native element/sprite depending on platform.

Contains a basic display lifecycle (initialize, update, remove)
Contains a basic display heirachy (addChild, removeChild)
Contains basic dispatching and bubbling via a Signal (dispatch)

Each target has a platform specific element for accessing the raw display API (flash: sprite, js: element)

@see msignal.Signal
@see DataView

*/
class UIComponent
{
	/**
	Event type dispatched when view is added to stage
	@see View.addChild()
	*/
	inline public static var ADDED:String = "added";

	/**
	Event type dispatched when view is removed from stage
	@see View.removeChild()
	*/
	inline public static var REMOVED:String = "removed";

	/**
	Event type dispatched when view is actioned (e.g. clicked)
	*/
	inline public static var ACTIONED:String = "actioned";

	/**
	private counter to maintain unique identifieds for created views
	*/
	static var idCounter:Int = 0;

	/**
	Unique identifier (viewXXX);
	*/
	public var id(default, null):String;
	
	/**
	reference to parent view (if available)
	@see View.addChild()
	@see View.removeChild()
	*/
	public var parent(default, null):UIComponent;

	/**
	reference to the index relative to siblings
	defaults to -1 when view has no parent 
	@see View.addChild()
	*/
	public var index(default, set_index):Int;
	
	@inject public var timer:Timer;
	
	@inject public var injector:Injector;
	
	public var instanceName(default, default):String;
	public var x(getX, setX):Float;
	public var y(getY, setY):Float;
	public var width(getWidth, setWidth):Float;
	public var height(getHeight, setHeight):Float;
	public var alpha(getAlpha, setAlpha):Float;
	public var visible(getVisible, setVisible):Bool;
	public var active(getActive, setActive):Bool;
	public var playheadTime(default, default):Int;
	
	var _x:Float;
	public function getX():Float {
		return _x;
	}
	public function setX(value:Float):Float {
		_x = value;
		#if js
		element.style.left = Std.string(_x) + "px";
		#end
		return _x;
	}
	
	var _y:Float;
	public function getY():Float {
		return _y;
	}
	public function setY(value:Float):Float {
		if (parent != null) {
			_y = value - parent.height;
		}
		_y = value;
		#if js
		element.style.top = Std.string(_y) + "px";
		#end
		return _y;
	}
	
	var _width:Float;
	public function getWidth():Float {
		return _width;
	}
	public function setWidth(value:Float):Float {
		_width = value;
		#if js
		element.style.width = Std.string(_width) + "px";
		#end
		return _width;
	}
	
	var _height:Float;
	public function getHeight():Float {
		return _height;
	}
	public function setHeight(value:Float):Float {
		_height = value;
		#if js
		element.style.height = Std.string(_height) + "px";
		#end
		return _height;
	}
	
	var _active:Bool;
	public function getActive():Bool {
		return _active;
	}
	public function setActive(value:Bool):Bool {
		_active = value;
		visible = value;
		return _active;
	}
	
	var _alpha:Float;
	public function getAlpha():Float {
		return _alpha;
	}
	public function setAlpha(value:Float):Float {
		_alpha = value;
		#if js
		Console.log("setting alpha " + _alpha);
		//element.style.opacity = Std.string(_alpha);
		jquery.css("opacity", Std.string(_alpha));
		#end
		return _alpha;
	}
	
	var _visible:Bool;
	public function getVisible():Bool {
		return _visible;
	}
	public function setVisible(value:Bool):Bool {
		_visible = value;
		#if js
		element.style.display = _visible ? "inline" : "none";
		#end
		return _visible;
	}
	
	var _dirty:Bool;
	
	var _plugins:Hash<UIComponentPlugin>;
	
	var _actions:Hash<Action>;

	/**
	Signal used for dispatching view events
	Usage:
		view.addListener(viewHandler);
		...
		function viewHandler(event:String, view:View);
	*/
	public var signal(default, null):Signal2<String, UIComponent>;

	#if flash

		/**
		native flash sprite representing this view in the display list
		*/
		public var sprite(default, null):Sprite;

	#elseif js

		/**
		native html element representing this view in the DOM
		*/
		public var element(default, null):HtmlDom;
		
		public var jquery:JQuery;
		
		/**
		Optional tag name to use when creating element via Lib.document.createElement
		defaults to 'div'
		*/
		var tagName:String;
	#end

	/**
	Contains all children currently added to view
	*/
	var children:Array<UIComponent>;

	/**
	String representation of unqualified class name
	(e.g. example.core.View.className == "View");
	*/
	var className:String;

	public function new()
	{
		_plugins = new Hash<UIComponentPlugin>();
		_actions = new Hash<ActionList>();
		_dirty = true;
		
		//create unique identifier for this view
		id = "view" + (idCounter ++);

		//set default index without triggering setter
		Reflect.setField(this, "index", -1);

		className = Type.getClassName(Type.getClass(this)).split(".").pop();
		
		children = [];
		signal = new Signal2<String, UIComponent>();
		
		initialize();
		
		x = 0;
		y = 0;
	}
	
	@post public function post():Void {
		timer.tick.add(onTick);
	}
	
	function onTick(value:Float):Void {
		//Console.log("ticking " + value);
		render();
	}

	public function toString():String
	{
		return className + "(" + id + ")";
	}

	/**
	dispatches a view event via the signal
	@param event 	string event type
	@param view 	originating view object
	*/
	public function dispatch(event:String, component:UIComponent)
	{
		if(component == null) component = this;
		signal.dispatch(event, component);
	}

	public function addPlugin(plugin:UIComponentPlugin):Void {
		if (_plugins.exists(plugin.name)) {
			_plugins.remove(plugin.name);
		}
		_plugins.set(plugin.name, plugin);
	}
	
	public function getPlugin(name:String):UIComponentPlugin {
		if (_plugins.exists(name)) {
			return _plugins.get(name);
		}
		return null;
	}
	
	public function addAction(action:Action):Void {
		if (!_actions.exists(action.event)) {
			_actions.set(action.event, new ActionList(action.event));
		}
		_actions.get(action.event).addAction(action);
	}
	
	public function handleEvent(e:Event):Void {
		triggerActions(e.type);
	}
	
	public function triggerActions(event:String):Void {
		if (_actions.exists(event)) {
			for (action in _actions) {
				action.execute();
			}
		}
	}

	/**
	Adds a child view to the display heirachy.
	
	Dispatches an ADDED event on completion.

	@param view 	child to add
	*/
	public function addChild(view:UIComponent)
	{
		view.signal.add(this.dispatch);
		view.parent = this;
		view.index = children.length;

		children.push(view);

		#if flash
		sprite.addChild(view.sprite);
		#elseif js
		//x -= parent.width;
		element.appendChild(view.element);
		#end

		dispatch(ADDED, view);
	}


	/**
	Removes an existing child view from the display heirachy.
	
	Dispatches an REMOVED event on completion.

	@param view 	child to remove
	*/
	public function removeChild(view:UIComponent)
	{
		var removed = children.remove(view);

		if(removed)
		{
			var oldIndex = view.index;

			view.remove();
			view.signal.remove(this.dispatch);
			view.parent = null;
			view.index = -1;

			#if flash
			sprite.removeChild(view.sprite);
			#elseif js
			element.removeChild(view.element);
			#end

			for(i in oldIndex...children.length)
			{
				var view = children[i];
				view.index = i;
			}

			dispatch(REMOVED, view);
		}
	}

	///// internal //////

	/**
	Initializes platform specific properties and state
	*/
	function initialize()
	{
		#if flash
		sprite = new Sprite();
		#elseif js
		if (tagName == null) tagName = "div";
		element = Lib.document.createElement(tagName);
		element.setAttribute("id", id);
		element.className = className;
		element.style.position = "relative";
		jquery = new JQuery(element);
		jquery.css("z-index", "2");
		#end
	}

	/**
	Removes platform specific properties and state
	*/
	function remove()
	{
		//override in sub class
	}

	/**
	Updates platform specific properties and state
	*/
	public function render():Void {
		//Console.log("X = " + _x);
		element.style.left = Std.string((parent != null) ? _x - parent.height : _x) + "px";
		
		if (_dirty) {
			_dirty = false;
			
			//#if js
			//element.
			//#end
		}
		
		for (plugin in _plugins) {
			plugin.resolve(this);
		}
	}

	/**
	Sets index and triggers an update when index changes
	@param value 	target index
	*/
	function set_index(value:Int):Int
	{
		if(index != value)
		{
			index = value;
			render();
		}
		
		return index;
	}

}

class ActionList {
	
	public var event(default, never):String;
	public var actions(getActions, never):Array<Action>;
	
	var _actions:Array<Action>;
	public function getActions():Array<Action> {
		return _actions;
	}
	
	public function new(event:String) {
		this.event = event;
		_actions = new Array<Action>();
	}
	
	public function addAction(action:Action):Void {
		_actions.push(action);
	}
}

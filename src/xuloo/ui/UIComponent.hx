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

import minject.Injector;
import msignal.Signal;
import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import nme.events.Event;

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
class UIComponent extends DisplayObjectContainer
{	
	@inject public var injector:Injector;
	
	public var interactiveLayer(default, default):IInteractiveLayer;
	
	public var instanceName(default, default):String;
	
	public var context(getContext, setContext):IComponentContext;
	var _context:IComponentContext;
	function getContext():IComponentContext {
		return _context = (_context == null) ? interactiveLayer.componentContext : _context;
	}
	function setContext(value:IComponentContext):IComponentContext {
		return _context = value;
	}
	
	public var active(getActive, setActive):Bool;
	public var includeInLayout(default, default):Bool;
	
	var _active:Bool;
	public function getActive():Bool {
		return _active;
	}
	public function setActive(value:Bool):Bool {
		_active = value;
		visible = value;
		return _active;
	}
	
	var _ready:Signal0;
	public var ready(getReady, never):Signal0;
	public function getReady():Signal0 {
		return _ready = (_ready == null) ? new Signal0() : _ready;
	}
	
	var _isReady:Bool;
	public var isReady(getIsReady, never):Bool;
	public function getIsReady():Bool {
		return _isReady;
	}
	
	var _dirty:Bool;
	
	var _plugins:Hash<UIComponentPlugin>;
	
	var _actions:Hash<ActionList>;

	public function new()
	{
		super();
		
		_plugins = new Hash<UIComponentPlugin>();
		_actions = new Hash<ActionList>();
		_dirty = true;
		
		initialize();
	}
	
	public function post():Void {
		
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
		
		Console.log("adding " + action.event + " operation");
		
		if (!hasEventListener(action.event)) {
			addEventListener(action.event, handleEvent);
		}
	}
	
	public function handleEvent(e:Event):Void {
		Console.log("handling event " + e.type);
		triggerActions(e.type);
	}
	
	public function triggerActions(event:String):Void {
		if (_actions.exists(event)) {
			for (action in _actions.get(event).actions) {
				Console.log("executing " + action);
				action.execute();
			}
		} else {
			Console.log("there are no actions for event type '" + event + "'");
		}
	}
	
	public function getComponentByName(name:String, ?recurse:Bool = false):UIComponent {

		for (i in 0...numChildren) {
			var child:DisplayObject = getChildAt(i);
			if (Std.is(child, UIComponent)) {
				var childComponent:UIComponent = cast(child, UIComponent);
				Console.log("checking '" + childComponent.instanceName + "' against '" + name + "'");
				if (childComponent.instanceName == name) {
					return childComponent;
				}
			}
		}

		if (recurse) {
			for (i in 0...numChildren) {
				var child:DisplayObject = getChildAt(i);
				if (Std.is(child, UIComponent)) {
					var childComponent:UIComponent = cast(child, UIComponent);
					var result:UIComponent = childComponent.getComponentByName(name, true);
					if (result != null) {
						return result;
					}
				}
			}
		}

		return null;
	}

	///// internal //////

	/**
	Initializes platform specific properties and state
	*/
	function initialize() {

	}

	/**
	Updates platform specific properties and state
	*/
	public function render():Void {
		
		for (plugin in _plugins) {
			plugin.resolve(this);
		}
	}
}

class ActionList {
	
	public var event(default, default):String;
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

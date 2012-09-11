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
import nme.events.IEventDispatcher;

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
class UIComponent implements IEventDispatcher
{	
	public var sprite(getSprite, never):DisplayObjectContainer;
	var _sprite:DisplayObjectContainer;
	public function getSprite():DisplayObjectContainer {
		return _sprite;
	}
	
	public var width(getWidth, setWidth):Float;
	public function getWidth():Float { return _sprite.width; }
	public function setWidth(value:Float):Float { return _sprite.width = value; }
	
	public var height(getHeight, setHeight):Float;
	public function getHeight():Float { return _sprite.height; }
	public function setHeight(value:Float):Float { return _sprite.height = value; }
	
	public var x (getX, setX):Float;
	public function getX():Float { return _sprite.x; }
	public function setX(value:Float):Float { return _sprite.x = value; }
	
	public var y(getY, setY):Float;
	public function getY():Float { return _sprite.y; }
	public function setY(value:Float):Float { return _sprite.y = value; }
	
	public var visible(getVisible, setVisible):Bool;
	public function getVisible():Bool { return _sprite.visible; }
	public function setVisible(value:Bool):Bool { return _sprite.visible = value; }
	
	public var alpha(getAlpha, setAlpha):Float;
	public function getAlpha():Float {return _sprite.alpha; }
	public function setAlpha(value:Float):Float { return _sprite.alpha = value; }
	
	public function addEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void {
		_sprite.addEventListener(type, listener, useCapture, priority, useWeakReference);
	}
    public function dispatchEvent(event : Event) : Bool {
    	return _sprite.dispatchEvent(event);
    }
    public function hasEventListener(type : String) : Bool {
    	return _sprite.hasEventListener(type);
    }
    public function removeEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false) : Void {
    	return _sprite.removeEventListener(type, listener, useCapture);
    }
    public function willTrigger(type : String) : Bool {
    	return _sprite.willTrigger(type);
    }
	
	public function addChild(value:DisplayObject):Void {
		_sprite.addChild(value);
	}
	
	public function removeChild(value:DisplayObject):Void {
		_sprite.removeChild(value);
	}

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
		_plugins = new Hash<UIComponentPlugin>();
		_actions = new Hash<ActionList>();
		_dirty = true;
		_sprite = new DisplayObjectContainer();
		
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

		for (i in 0..._sprite.numChildren) {
			var child:DisplayObject = _sprite.getChildAt(i);
			if (Std.is(child, UIComponent)) {
				var childComponent:UIComponent = cast(child, UIComponent);
				Console.log("checking '" + childComponent.instanceName + "' against '" + name + "'");
				if (childComponent.instanceName == name) {
					return childComponent;
				}
			}
		}

		if (recurse) {
			for (i in 0..._sprite.numChildren) {
				var child:DisplayObject = _sprite.getChildAt(i);
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

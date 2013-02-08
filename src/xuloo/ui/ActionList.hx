package xuloo.ui;

class ActionList {
	
	public var event(default, default):String;
	public var actions(getActions, never):Array<Dynamic>;
	
	var _actions:Array<Dynamic>;
	public function getActions():Array<Dynamic> {
		if (_actions == null) _actions = new Array<Dynamic>();
		return _actions;
	}
	
	public function new(event:String) {
		this.event = event;
	}
	
	public function addAction(action:Action):Void {
		actions.push(action);
	}

	public function toString():String {
		return "[ActionList('" + event + "', " + _actions + ")]";
	}
}
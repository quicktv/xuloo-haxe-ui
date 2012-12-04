package xuloo.ui;

/**
 * ...
 * @author Trevor B
 */

class UIComponentPlugin 
{
	public var instanceName(default, default):String;
	public var name(getName, setName):String;
	
	var _name:String;
	public function getName():String {
		return _name;
	}
	public function setName(value:String):String {
		return _name = value;
	}
	
	public function new(?name:String) {
		this.name = name;
	}
	
	public function resolve(target:UIComponent):Void {
		
	}
	
}
package xuloo.ui;

/**
 * ...
 * @author Trevor B
 */

class UIComponentPlugin 
{
	public var name(default, default):String;
	
	public function new(?name:String) {
		this.name = name;
	}
	
	public function resolve(target:UIComponent):Void {
		
	}
	
}
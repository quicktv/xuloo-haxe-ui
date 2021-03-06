package xuloo.ui;

class FlashVars
{
	private var _params:Hash<String>;
	
	public function new(params:Dynamic) {
		_params = params;
	}
	
	public function getOrElse(property:String, defaultValue:String):String {

		if (has(property))
		{
			return _params.get(property);
		}
		
		return defaultValue;
	}
	
	public function has(property:String):Bool {
		return _params.exists(property);
	}
	
	public function hasAll(properties:Array<String>):Bool {
		var bool:Bool = true;
		
		for (property in properties)
		{
			if (!has(property)) 
			{
				bool = false;
				break;
			}
		}
		
		return bool;
	}
	
	public function hasAny(properties:Array<String>):Bool {
		for (property in properties)
		{
			if (has(property)) return true;
		}
		
		return false;
	}
}
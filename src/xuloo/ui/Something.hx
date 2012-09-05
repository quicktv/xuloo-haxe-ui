package xuloo.ui;

class Something<T> extends OptionBase<T>
{
	private var _value:T;
	
	public override function getValue():T {
		return _value;
	}
	
	public override function isDefined():Bool {
		return true;
	}
	
	public function new(value:T) {
		super();
		_value = value;
	}
}
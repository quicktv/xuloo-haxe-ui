package xuloo.ui;

class Nothing<T> extends OptionBase<T>
{
	public override function isDefined():Bool {
		return false;
	}
	
	public override function getValue():T {
		return null;
	}
	
	public function new() {
		super();
	}
}
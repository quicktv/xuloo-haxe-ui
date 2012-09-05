package xuloo.ui;

class OptionBase<T> implements IOption<T>
{
	public function new() {
	}
	
	public function getValue():T
	{
		return null;
	}
	
	public function getOrElse(or:T):T
	{
		if (isDefined()) return getValue();
		
		/*if (or is Function)
		{
			return or();
		}*/
		
		return or;
	}
	
	public function isDefined():Bool
	{
		return false;
	}
}
package xuloo.ui;

interface IOption<T> implements IDefinable
{		
	function getValue():T;
	
	function getOrElse(or:T):T;
}
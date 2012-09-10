package xuloo.ui;

/**
 * ...
 * @author Trevor B
 */

class Container extends UIComponent 
{
	public var layout(never, setLayout):Layout;
	
	var _layout:Layout;
	function setLayout(value:Layout):Layout {
		return _layout = value;
	}
	
	public function new() {
		super();
	}
	
	public override function render():Void {
		super.render();
		_layout.render();
	}
}
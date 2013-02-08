package xuloo.ui;

class TargetAwareAction extends Action {

	public var target(default, setTarget):String;
	
	var _target:String;
	public function setTarget(value:String):String {
		return _target = value;
	}
	
	var _targetComponent:UIComponent;
	function getTargetComponent():UIComponent {
		if (_targetComponent == null) {
			_targetComponent = interactiveLayer.getComponentByName(_target);
		}
		return _targetComponent;
	}

	public function new() {
		super();
	}
}
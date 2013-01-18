package xuloo.ui;

import xuloo.ui.IVersions;

class ComponentContext implements IComponentContext
{
	public var editing(getEditing, never):Bool;
	public var previewing(getPreviewing, never):Bool;
	public var root(getRoot, setRoot):UIComponent;
	public var projectId(getProjectId, never):Int;
	
	var _editing:Bool;	
	public function getEditing():Bool {
		return _editing;
	}
	
	var _previewing:Bool;
	public function getPreviewing():Bool {
		return _previewing;
	}
	
	var _root:UIComponent;	
	public function getRoot():UIComponent {
		return _root;
	}
	public function setRoot(value:UIComponent):UIComponent {
		return _root = value;
	}
	
	var _projectId:Int;	
	public function getProjectId():Int {
		return _projectId;
	}
	
	public function new(editing:Bool, previewing:Bool, root:UIComponent, projectId:Int) {
		_editing = editing;
		_previewing = previewing;
		_root = root;
		_projectId = projectId;
	}
	
	public function toString():String 
	{
		return "ComponentContext[" + _projectId + "]";
	}
}
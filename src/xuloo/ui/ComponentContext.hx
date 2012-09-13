package xuloo.ui;

import xuloo.ui.IVersions;

class ComponentContext implements IComponentContext
{
	public var editing(getEditing, never):Bool;
	public var previewing(getPreviewing, never):Bool;
	public var root(getRoot, setRoot):UIComponent;
	public var serverContext(getServerContext, never):String;
	public var releaseBucket(getReleaseBucket, never):String;
	public var versions(getVersions, never):IVersions;
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
	
	var _serverContext:String;	
	public function getServerContext():String {
		return _serverContext;
	}
	
	var _releaseBucket:String;	
	public function getReleaseBucket():String {
		return _releaseBucket;
	}
	
	var _versions:IVersions;
	public function getVersions():IVersions {
		return _versions;
	}
	
	var _projectId:Int;	
	public function getProjectId():Int {
		return _projectId;
	}
	
	public function new(editing:Bool, previewing:Bool, root:UIComponent, serverContext:String, releaseBucket:String, versions:IVersions, projectId:Int) {
		_editing = editing;
		_previewing = previewing;
		_root = root;
		_serverContext = serverContext;
		_releaseBucket = releaseBucket;
		_versions = versions;
		_projectId = projectId;
	}
	
	public function toString():String 
	{
		return "ComponentContext[" + _serverContext + "]";
	}
}
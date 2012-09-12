package xuloo.ui;

import qtv.api.core.IVersions;

public class ComponentContext implements IComponentContext
{
	var editing(getEditing, never):Bool;
	var previewing(getPreviewing, never):Bool;
	var root(getRoot, setRoot):UIComponent;
	var serverContext(getServerContext, never):String;
	var releaseBucket(getReleaseBucket, never):String;
	var versions(getVersions, never):IVersions;
	var projectId(getProjectId, never):Int;
	
	var _editing:Boolean;	
	public function getEditing():Bool {
		return _editing;
	}
	
	var _previewing:Bool;
	public function get previewing():Bool {
		return _previewing;
	}
	
	var _root:UIComponent;	
	public function getRoot():UIComponent {
		return _root;
	}
	public function set components(value:UIComponent):void {
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
		_components = components;
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
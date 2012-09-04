package xuloo.ui;

/**
 * An IComponentContext abstracts the environment in which a runtime component lives
 * hiding the details of the surrounding engine implementation. 
 */
interface IComponentContext
{
	var editing(getEditing, never):Bool;
	var previewing(getPreviewing, never):Bool;
	var components(getComponents, setComponents):Array<UIComponent>;
	var serverContext(getServerContext, never):String;
	var releaseBucket(getReleaseBucket, never):String;
	var versions(getVersions, never):IVersions;
	var projectId(getProjectId, never):Int;
	
	function getEditing():Bool;
	function getPreviewing():Bool;	
	function getComponents():Array<UIComponent>;
	function setComponents(value:Array<UIComponent>):Array<UIComponent>;	
	function getServerContext():String;	
	function getReleaseBucket():String;	
	function getVersions():IVersions;	
	function getProjectId():Int;
}
package xuloo.ui;

/**
 * An IComponentContext abstracts the environment in which a runtime component lives
 * hiding the details of the surrounding engine implementation. 
 */
interface IComponentContext
{
	var editing(getEditing, never):Bool;
	var previewing(getPreviewing, never):Bool;
	var root(getRoot, setRoot):UIComponent;
	var projectId(getProjectId, never):Int;
	
	function getEditing():Bool;
	function getPreviewing():Bool;	
	function getRoot():UIComponent;
	function setRoot(value:UIComponent):UIComponent;		
	function getProjectId():Int;
}
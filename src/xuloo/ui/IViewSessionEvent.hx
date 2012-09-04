package xuloo.ui;

interface IViewSessionEvent implements IJSON
{
	var eventType(getEventType, never):ViewSessionEventType;
	var eventData(getEventData, never):Dynamic;
	var time(getTime, never):Int;
	
	function getEventType():ViewSessionEventType;	
	function getEventData():Dynamic;	
	function getTime():Int;
}
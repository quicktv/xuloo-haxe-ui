package xuloo.ui;

interface IQtvSwfAsset
{
	function displayThumbnail():Void;
	function init():Void;
	function start():Void;
	function finish():Void;
	function playheadUpdate(value:Int):Void;
}
package xuloo.ui;

interface ISWF
{
	public var width(getWidth, never):Float;
	public var height(getHeight, never):Float;

	function getWidth():Float;
	function getHeight():Float;
	
	function play():Void;
	function stop():Void;
	function gotoAndStop(frame:Int):Void;
}
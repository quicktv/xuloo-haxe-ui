package xuloo.ui;

interface IVideoController {
	
	var playheadTime(getPlayheadTime, setPlayheadTime):Int;
	var volume(getVolume, setVolume):Float;
	
	function play():Void;
	function pause():Void;
	function stop():Void;	
	
	function getPlayheadTime():Int;
	function setPlayheadTime(value:Int):Int;
	
	function getVolume():Float;
	function setVolume(value:Float):Float;
}
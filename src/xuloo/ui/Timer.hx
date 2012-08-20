package xuloo.ui;

import haxe.Timer;
import msignal.Signal;

/**
 * ...
 * @author Trevor B
 */

class Timer 
{
	var _started:Bool;
	var _startTime:Float;
	
	public var tick(getTick, never):Signal1<Float>;
	
	var _tick:Signal1<Float>;
	public function getTick():Signal1<Float> {
		if (_tick == null) {
			_tick = new Signal1<Float>();
		}
		return _tick;
	}
	
	var _timer:haxe.Timer;
	
	public function new() {
		_started = false;
		
		_timer = new haxe.Timer(50);
		_timer.run = run;
	}
	
	private function run():Void {
		if (!_started) {
			_started = true;
			_startTime = haxe.Timer.stamp() * 1000;
		}
		tick.dispatch(haxe.Timer.stamp() * 1000 - _startTime);
	}
}
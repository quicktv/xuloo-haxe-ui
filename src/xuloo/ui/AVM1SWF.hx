package xuloo.ui;

import flash.display.AVM1Movie;

class AVM1SWF implements ISWF {
	public var width(getWidth, never) : Float;
	public var height(getHeight, never) : Float;

	var _target : AVM1Movie;
	public function getWidth() : Float {
		return _target.width;
	}

	public function getHeight() : Float {
		return _target.height;
	}

	public function new(target : AVM1Movie) {
		_target = target;
	}

	public function play() : Void {
	}

	public function stop() : Void {
	}

	public function gotoAndStop(frame : Float) : Void {
	}

}


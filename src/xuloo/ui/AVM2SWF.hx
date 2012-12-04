package xuloo.ui;

import flash.display.MovieClip;

class AVM2SWF implements ISWF {
	public var width(getWidth, never) : Float;
	public var height(getHeight, never) : Float;

	var _target : MovieClip;
	public function getWidth() : Float {
		return _target.width;
	}

	public function getHeight() : Float {
		return _target.height;
	}

	public function new(target : MovieClip) {
		_target = target;
	}

	public function play() : Void {
		_target.play();
	}

	public function stop() : Void {
		_target.stop();
	}

	public function gotoAndStop(frame : Int) : Void {
		_target.gotoAndStop(frame);
	}

}


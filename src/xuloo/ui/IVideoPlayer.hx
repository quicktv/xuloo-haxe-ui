package xuloo.ui;

import msignal.Signal;
import qtv.api.core.IVideo;

interface IVideoPlayer implements IVideoController
{
	var ready(getReady, never):Signal0;
	var isReady(getIsReady, never):Bool;
	var complete(getComplete, never):Signal0;
	var stateChanged(getStateChanged, never):Signal1<PlayerState>;
	var currentState(getCurrentState, never):PlayerState;
	var volumeChanged(getVolumeChanged, never):Signal1<Float>;
	var playheadTimeChanged(getPlayheadTimeChanged, never):Signal1<Int>;
	var video(never, setVideo):IVideo;
	var onPlay(getOnPlay, never):Signal0;
	var onPause(getOnPause, never):Signal0;
	var onStop(getOnStop, never):Signal0;
	
	function getReady():Signal0;
	function getIsReady():Bool;	
	function getComplete():Signal0;	
	function getStateChanged():Signal1<PlayerState>;	
	function getCurrentState():PlayerState;	
	function getVolumeChanged():Signal1<Float>;	
	function getPlayheadTimeChanged():Signal1<Int>;	
	function setVideo(value:IVideo):IVideo;		
	function getOnPlay():Signal0;
	function getOnPause():Signal0;
	function getOnStop():Signal0;	
	
	function init():Void;
}
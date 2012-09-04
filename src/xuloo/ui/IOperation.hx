package xuloo.ui;

import msignal.Signal;

interface IOperation<T> implements ICommand
{
	var displayName(getDisplayName, setDisplayName):String;
	
	function getDisplayName():String;
	function setDisplayName(value:String):String;
	
	var completeSignal(getCompleteSignal, never):Signal1<IOperation<T>>;
	
	function getCompleteSignal():Signal1<IOperation<T>>;
	
	var errorSignal(getErrorSignal, never):Signal1<IOperation<T>>;
	
	function getErrorSignal():Signal1<IOperation<T>>;
	
	function addCompleteListener(f:IOperation<T> -> Void):IOperation<T>;
	function removeCompleteListener(f:IOperation<T> -> Void):IOperation<T>;
	
	function addErrorListener(f:IOperation<T> -> Void):IOperation<T>;
	function removeErrorListener(f:IOperation<T> -> Void):IOperation<T>;
	
	function addProgressListener(f:IOperation<T> -> Void):IOperation<T>;
	function removeProgressListener(f:IOperation<T> -> Void):IOperation<T>;
	
	var result(getResult, never):IOption<T>;
	
	function getResult():IOption<T>;
	
	var error(getError, never):IOption<Dynamic>;
	
	function getError():IOption<Dynamic>;
	
	var progress(getProgress, never):Float;
	
	function getProgress():Float;
}
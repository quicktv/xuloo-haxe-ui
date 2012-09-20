package xuloo.ui;

import qtv.operations.api.IOperation;

interface IComponentService {
	var context(getContext, setContext):IComponentContext;
	
	function getContext():IComponentContext;
	function setContext(value:IComponentContext):IComponentContext;
	function newSession():IOperation<Int>;
	function dispatchEvent(e:IViewSessionEvent):IOperation<Dynamic>;
}
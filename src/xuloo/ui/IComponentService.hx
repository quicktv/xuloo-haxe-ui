package xuloo.ui;

interface IComponentService {
	var context(getContext, setContext):IComponentContext;
	
	function getContext():IComponentContext;
	function setContext(value:IComponentContext):IComponentContext;
	function newSession():IOperation<IViewSessionEvent>;
	function dispatchEvent(e:IViewSessionEvent):IOperation<IViewSessionEvent>;
}
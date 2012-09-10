package xuloo.ui;

import mmvc.api.IViewContainer;
import qtv.ui.ComponentBuilder;

/**
 * ...
 * @author Trevor B
 */

class InteractiveLayer extends UIComponent, implements IViewContainer
{
	public var viewAdded:Dynamic -> Void;
	public var viewRemoved:Dynamic -> Void;
	
	var _root:UIComponent;
	
	public override function getComponentByName(name:String, ?recurse:Bool = false):UIComponent {
		if (_root.instanceName == name) return _root;
		return _root.getComponentByName(name, true);
	}
	
	@inject public var builder:ComponentBuilder;

	public function new() {
		super();
	}
	
	@post public override function post():Void {
		super.post();
		
		//%video(buildData.video)%
		
		//%componentInstance(buildData.root)%
	}
	
	public function isAdded(view:Dynamic):Bool
	{
		return true;
	}
	
	override function initialize()
	{
		super.initialize();

		nme.Lib.current.addChild(this);
	}	
}
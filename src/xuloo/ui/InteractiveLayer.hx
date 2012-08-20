package xuloo.ui;

import minject.Injector;
import mmvc.api.IViewContainer;

/**
 * ...
 * @author Trevor B
 */

class InteractiveLayer extends View, implements IViewContainer
{
	public var viewAdded:Dynamic -> Void;
	public var viewRemoved:Dynamic -> Void;

	public function new() {
		super();
	}
	
	@post public override function post():Void {
		super.post();
		
		var image:ImageComponent = new ImageComponent();
		injector.injectInto(image);
		image.width = 100;
		image.height = 100;
		
		var text:TextComponent = new TextComponent();
		text.text = "hello, i'm some text";
		
		var video:VideoComponent = new VideoComponent();
		injector.injectInto(video);
		addChild(video);
		
		video.addChild(image);
		
		image.addChild(text);

		video.x = 200;
		//video.y = 0;
		video.width = 500;
		video.height = 300;
		
		image.src = "http://4.bp.blogspot.com/-IrNsTcsa_6w/Tj2vUlRCtfI/AAAAAAAABWE/dbgKX5gzSFc/s1600/yorkshire+pudding.jpg";

	}
	
	public function isAdded(view:Dynamic):Bool
	{
		return true;
	}
	
	override function initialize()
	{
		super.initialize();
		#if flash
			flash.Lib.current.addChild(sprite);
		#elseif js
			js.Lib.document.body.appendChild(element);
		#end
	}
	
}
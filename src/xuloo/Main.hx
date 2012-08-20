package xuloo;

import example.app.ApplicationContext;
import example.app.ApplicationView;
import example.core.ImageComponent;
import example.core.InteractiveLayer;
import example.core.TextComponent;
import example.core.VideoComponent;
import js.Lib;
import mmvc.impl.Context;

/**
 * ...
 * @author Trevor B
 */

class Main
{
	
	static function main() 
	{
		Console.start();
		
		var layer:InteractiveLayer = new InteractiveLayer();
		var context:ApplicationContext = new ApplicationContext(layer);

		context.injector.injectInto(layer);
	}
	
}
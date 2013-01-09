package xuloo.ui;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.net.URLRequest;
#if flash
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
#elseif js
import jeash.system.Security;
#end
import qtv.operations.api.IOperation;

class BasicImage extends UIComponent {
	public var source(getSource, setSource) : Dynamic;

	public var target(getTarget, setTarget) : String;

	/**
	 * Setting up external link reference.
	 * @private 
	 */
	//var _link : String;
	/**
	 * Setting up external link reference's target window.
	 * @private
	 */
	var _target : String;
	/**
	 * Setting up the textual context of a tooltip.
	 * @private
	 */
	//var _tooltip : String;
	/**
	 * Setting up loader instance.
	 * @private 
	 */
	var loader : Loader;
	/**
        * Setting up source for image to load in loader object
        * @private 
        */
	var _source : Dynamic;
	/**
        * Override width property so that we can tell if width has been explicitly set
        * @private 
        */
	var _width : Float;
	/**
        * Override height property so that we can tell if width has been explicitly set 
        * @private 
        */
	var _height : Float;
	var image : Bitmap;
	var originalDimensions : Rectangle;
	public function new() {
		super();
		_target = "_blank";
		//_tooltipArea = new ToolTip();
		originalDimensions = new Rectangle();
		Security.allowDomain("*");
		loader = new Loader();
	}

	/**
	 * Overrides the default operation registration.
	 * We want to give the user feedback that a mouse operation is available.
	 * So as well as just registering the operation we activate the handcursor
	 * if the event type being registered is a mouse op.
	 */
	override public function addAction(action:Action):Void {
		super.addAction(action);
		if(action.event.toLowerCase().indexOf("mouse") > -1 || action.event.toLowerCase().indexOf("click") > -1 || action.event.toLowerCase().indexOf("roll") > -1)  {
			sprite.useHandCursor = sprite.buttonMode = true;
		}
	}

	/**
        * When image loads, re-set the width and height of this Sprite to either
        * the explicit values or to the image's own size.
        */
	public function handleLoadComplete(evt : Event) : Void {

		var loaderInfo:LoaderInfo = cast(evt.target, LoaderInfo);
		var content : DisplayObject = cast(loaderInfo.content, DisplayObject);
		image = cast(loaderInfo.content, Bitmap);
		sprite.addChild(image);

		_width = (Math.isNaN(_width)) ? image.width : _width;
		_height = (Math.isNaN(_height)) ? image.height : _height;

		invalidateDimensions();
		// Dispatch an event in case anyone (like the editor) was waiting for us figure out our dimensions.
		dispatchEvent(new Event(Event.COMPLETE));
	}

	function handleLoadError(evt : IOErrorEvent) : Void {
		Console.log("image load error " + evt);
	}

	function handleLoadStatus(evt : HTTPStatusEvent) : Void {
		Console.log("image load status " + evt.status);
		if(evt.status != 200) { }
	}

	/**
        * Override width property so that we can tell if width has been explicitly set.
        */
	override public function getWidth() : Float {
		return _width;
	}

	override public function setWidth(value : Float) : Float {
		super.setWidth(_width = value);
		invalidateDimensions();
		return value;
	}

	/**
        * Override height property so that we can tell if height has been explicitly set.
        */
	override public function getHeight() : Float {
		return _height;
	}

	/**
        * Override height property so that we can tell if height has been explicitly set.
        */
	override public function setHeight(value : Float) : Float {
		super.setHeight(_height = value);
		invalidateDimensions();
		return value;
	}

	function invalidateDimensions() : Void {
		Console.log("invalidating dimensions");
		/*CONFIG::debug {
		logger.debug("invalidating dimensions {0} {1}x{2}", [image, _width, _height]);
		}*/
		if(Std.is(source, Bitmap))  {
			/*CONFIG::debug {
			logger.debug("invalidating dimensions {0}x{1}", [width, height]);
			}*/
			if(!Math.isNaN(_width) && !Math.isNaN(_height))  {
				_source.width = _width;
				_source.height = _height;
			}
		}
		Console.log(image + " " + _width + " " + _height + " " + width + " " + height);
		if(image != null)  {
			if(!Math.isNaN(_width) && !Math.isNaN(_height))  {
				var matrix : Matrix = new Matrix();
				matrix.scale(width / image.width, height / image.height);
				sprite.graphics.clear();
				sprite.graphics.beginBitmapFill(image.bitmapData, matrix, false, true);
				sprite.graphics.drawRect(0, 0, width - 1, height);
				sprite.graphics.endFill();
			}
		}
	}

	var _sourceKey : Dynamic;
	/**
        * To get current source ,path of image
        */
	public function getSource() : Dynamic {
		return _source;
	}

	/**
        * To set current source and it load the image into loader
        */
	public function setSource(value : Dynamic) : Dynamic {
		doSetSource(value);
		return value;
	}

	function doSetSource(value : Dynamic) : Void {
		Console.log("setting image source " + value);
		if(Std.is(value, String))  {
			var domain : String = ((value.indexOf("http://") == -1 && value.indexOf("https://") == -1)) ? context.serverContext : "";
			_source = domain + value;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoadComplete, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, handleLoadStatus, false, 0, true);
			#if flash
			loader.load(new URLRequest(_source), new LoaderContext(true, ApplicationDomain.currentDomain));
			#elseif js
			loader.load(new URLRequest(_source));
			#end
		}

		else if(Std.is(value, Bitmap))  {
			addChild(_source = cast(value, Bitmap));
			invalidateDimensions();
		}
		visible = true;
		alpha = 1;
	}

	/**
	 * Sets up the target window for the link to open into.
	 * @return String
	 */
	public function getTarget() : String {
		return _target;
	}

	public function setTarget(value : String) : String {
		return _target = value;
	}
}


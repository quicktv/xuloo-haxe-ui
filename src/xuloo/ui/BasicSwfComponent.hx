package xuloo.ui;


#if flash
import flash.display.AVM1Movie;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.events.SecurityErrorEvent;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.system.Security;
import flash.utils.ByteArray;

import qtv.operations.api.IOperation;

import xuloo.ui.IQtvSwfAsset;
import xuloo.ui.ISWF;
#end
import xuloo.ui.UIComponent;

class BasicSwfComponent extends UIComponent {

	var _source : Dynamic;
	public var source(getSource, setSource) : Dynamic;

	/**
	 * To get current source ,path of image
	 */
	public function getSource() : Dynamic {
		return _source;
	}

	#if flash

	/**
	 * Setting up loader instance.
	 * @private 
	 */
	var urlLoader : URLLoader;
	/**
	 * Setting up loader instance.
	 * @private 
	 */
	var loader : Loader;
	/**
	 * Setting up MovieClip instance.
	 * @private 
	 */
	public var movieClip : ISWF;
	
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
	var loaderScaleX : Float;
	var loaderScaleY : Float;

	public function new() {
		super();

		originalDimensions = new Rectangle();
		loaderScaleX = 1;
		loaderScaleY = 1;
		Security.allowDomain("*");
		loader = new Loader();
	}

	/**
	 * When swf loads, re-set the width and height of this Sprite to either
	 * the explicit values or to the image's own size.
	 */
	public function handleLoadComplete(evt : Event) : Void {
		movieClip = Std.is(loader.content, AVM1Movie) ? new AVM1SWF(cast(loader.content, AVM1Movie)) : new AVM2SWF(cast(loader.content, MovieClip));

		movieClip.gotoAndStop(1);

		_width = (Math.isNaN(_width)) ? loader.contentLoaderInfo.width : _width;
		_height = (Math.isNaN(_height)) ? loader.contentLoaderInfo.height : _height;
		loaderScaleX = movieClip.width / loader.contentLoaderInfo.width;
		loaderScaleY = movieClip.height / loader.contentLoaderInfo.height;
		invalidateDimensions();
		// Dispatch an event in case anyone (like the editor) was waiting for us figure out our dimensions.
		dispatchEvent(new Event(Event.COMPLETE));
	}

	function handleLoadError(evt : IOErrorEvent) : Void {
	}

	function handleSecurityError(evt : SecurityErrorEvent) : Void {
	}

	function handleLoadStatus(evt : HTTPStatusEvent) : Void {
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
		if(movieClip != null)  {
			loader.width = width * loaderScaleX;
			loader.height = height * loaderScaleY;
		}
	}

	var _sourceKey : Dynamic;

	/**
	 * To set current source and it load the image into loader
	 */
	public function setSource(value : Dynamic) : Dynamic {
		doSetSource(value);

		return value;
	}

	function doSetSource(value : Dynamic) : Void {
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoadComplete, false, 0, true);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError, false, 0, true);
		loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecurityError, false, 0, true);
		loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, handleLoadStatus, false, 0, true);

		if(Std.is(value, String))  {
			var domain : String = "";
			_source = domain + value;
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, onRawLoadComplete);
			urlLoader.load(new URLRequest(_source));
		}

		else  {
			_source = value;
			addChild(_source = cast(value, DisplayObject));
			_source.width = _width;
			_source.height = _height;
		}

		sprite.addChild(loader);
		visible = true;
		alpha = 1;
	}

	function onRawLoadComplete(e : Event) : Void {
		var ba : ByteArray = new ByteArray();
		(cast((e.target), URLLoader).data).readBytes(ba);
		loader.loadBytes(ba);
	}

	override function setActive(value : Bool) : Bool {
		// start
		if(movieClip != null)  {
			if(!active && value)  {
				if(Std.is(movieClip, IQtvSwfAsset))  {
					cast((movieClip), IQtvSwfAsset).start();
				}

				else  {
					movieClip.play();
				}

			}

			else if(active && !value)  {
				// stop
				if(Std.is(movieClip, IQtvSwfAsset))  {
					cast((movieClip), IQtvSwfAsset).finish();
				}

				else  {
					movieClip.stop();
				}

			}
		}
		
		return super.setActive(value);
	}
	#elseif js

	public function new() {
		super();
	}

	public function setSource(value : Dynamic) : Dynamic {
		return _source = value;
	}

	#end

}


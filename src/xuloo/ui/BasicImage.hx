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
	//public var link(getLink, setLink) : String;
	public var target(getTarget, setTarget) : String;
	//public var tooltip(getTooltip, setTooltip) : String;

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

	//function invalidateLink() : Void {
		/*var isLink:Boolean = isValidLink( _link );
		if( isLink )
		{
		if( !hasEventListener( MouseEvent.CLICK ) )
		addEventListener( MouseEvent.CLICK, handleClick, false, 0, true );
		buttonMode = useHandCursor = true;
		}
		else
		{
		if( hasEventListener( MouseEvent.CLICK ) )
		removeEventListener( MouseEvent.CLICK, handleClick, false );
		}*/
	//}

	//function invalidateTooltip() : Void {
		/*var isTooltip:Boolean = isValidTooltip( _tooltip );
		if( isTooltip )
		{
		_tooltipArea.text = _tooltip;
		if( !hasEventListener( MouseEvent.ROLL_OVER ) )
		{
		addEventListener( MouseEvent.ROLL_OVER, handleRollOver, false, 0, true );
		addEventListener( MouseEvent.ROLL_OUT, handleRollOut, false, 0, true );
		}
		buttonMode = useHandCursor = true;
		}
		else
		{
		if( hasEventListener( MouseEvent.ROLL_OVER ) )
		{
		removeEventListener( MouseEvent.ROLL_OVER, handleRollOver, false );
		removeEventListener( MouseEvent.ROLL_OUT, handleRollOut, false );
		}
		}*/
	//}

	/*function isValidLink(link : String) : Bool {
		return (link != null && link != "");
	}*/

	/*function isValidTooltip(tooltip : String) : Bool {
		return (tooltip != null && tooltip != "");
	}*/

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

	/*override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
	{
	super.addEventListener( type, listener, useCapture, priority, useWeakReference );
	if( type.toLowerCase().indexOf( "mouse" ) || type.toLowerCase().indexOf( "click" ) || type.toLowerCase().indexOf( "roll" ) )
	{
	mouseChildren = false;
	useHandCursor = buttonMode = true;
	}
	}*/
	/**
        * When image loads, re-set the width and height of this Sprite to either
        * the explicit values or to the image's own size.
        */
	public function handleLoadComplete(evt : Event) : Void {
		var loaderInfo:LoaderInfo = cast(evt.target, LoaderInfo);
		var content : DisplayObject = cast(loaderInfo.content, DisplayObject);
		image = cast(loaderInfo.content, Bitmap);
		_width = (Math.isNaN(_width)) ? image.width : _width;
		_height = (Math.isNaN(_height)) ? image.height : _height;
		invalidateDimensions();
		// Dispatch an event in case anyone (like the editor) was waiting for us figure out our dimensions.
		dispatchEvent(new Event(Event.COMPLETE));
	}

	function handleLoadError(evt : IOErrorEvent) : Void {
	}

	function handleLoadStatus(evt : HTTPStatusEvent) : Void {
		if(evt.status != 200) { }
	}

	/*public function handleClick(evt : MouseEvent) : Void {
		if(!context.editing)  {
			navigateToURL(new URLRequest(_link), _target);
		}
	}*/

	/*public function handleRollOver(evt : MouseEvent) : Void {
		_tooltipArea.x = Math.max(10, Math.min(stage.stageWidth - _tooltipArea.width - 10, x + 10));
		_tooltipArea.y = Math.max(10, Math.min(stage.stageHeight - _tooltipArea.height - 10, y + -_tooltipArea.height - 4));
		stage.addChild(_tooltipArea);
	}*/

	/*public function handleRollOut(evt : MouseEvent) : Void {
		sprite.stage.removeChild(_tooltipArea);
	}*/

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
		//if(dataComponent == null)  {
			doSetSource(value);
		//}

		/*else  {
			_sourceKey = value;
			dataComponent.addEventListener(Event.COMPLETE, dataLoaded, false, 0, true);
			dataComponent.loadData();
		}
*/
		return value;
	}

	/*function dataLoaded(event : Event = null) : Void {
		if(dataComponent.hasEventListener(Event.COMPLETE)) dataComponent.removeEventListener(Event.COMPLETE, dataLoaded);
		doSetSource(dataComponent.getValue(_sourceKey));
	}*/

	function doSetSource(value : Dynamic) : Void {
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
	 * Sets the link to follow upon click of instance. 
	 * @return String
	 *//*
	public function getLink() : String {
		return _link;
	}*/

	/*public function setLink(value : String) : String {
		_link = value;
		invalidateLink();
		return value;
	}*/

	/**
	 * Sets up the target window for the link to open into.
	 * @return String
	 */
	public function getTarget() : String {
		return _target;
	}

	public function setTarget(value : String) : String {
		_target = value;
		//invalidateLink();
		return value;
	}

	/**
	 * Sets the textual context for a tooltip. 
	 * @return String
	 */
	/*public function getTooltip() : String {
		return _tooltip;
	}*/

	/*public function setTooltip(value : String) : String {
		_tooltip = value;
		invalidateTooltip();
		return value;
	}*/

	/*override public function applyPropertyValue(name : Dynamic, value : Dynamic) : Void {
		*//*if (name == "source")
		{
		dataComponent.applyPropertyValue(name, value, this).execute();
		}
		else
		{*/
		//super.applyPropertyValue(name, value);
		/*}*//*
	}*/

}


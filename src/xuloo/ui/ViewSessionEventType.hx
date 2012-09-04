package xuloo.ui;

enum ViewSessionEventType {
	
	VIDEO_STOPPED;
	VIDEO_STARTED;
	VIDEO_PAUSED;
	COMPONENT_CLICKED;
	OPERATION_EXECUTED;
	
	/*private static const VIDEO_STOPPED_KEY:String = "VIDEO_STOPPED";
	private static const VIDEO_STARTED_KEY:String = "VIDEO_STARTED";
	private static const VIDEO_PAUSED_KEY:String = "VIDEO_PAUSED";
	private static const COMPONENT_CLICKED_KEY:String = "COMPONENT_CLICKED";
	private static const OPERATION_EXECUTED_KEY:String = "OPERATION_EXECUTED";
	
	public static const VIDEO_STOPPED:ViewSessionEventType = new ViewSessionEventType(VIDEO_STOPPED_KEY);
	public static const VIDEO_STARTED:ViewSessionEventType = new ViewSessionEventType(VIDEO_STARTED_KEY);
	public static const VIDEO_PAUSED:ViewSessionEventType = new ViewSessionEventType(VIDEO_PAUSED_KEY);
	public static const COMPONENT_CLICKED:ViewSessionEventType = new ViewSessionEventType(COMPONENT_CLICKED_KEY);
	public static const OPERATION_EXECUTED:ViewSessionEventType = new ViewSessionEventType(OPERATION_EXECUTED_KEY);
	
	private static var _enumCreated:Boolean;
	
	{
		_enumCreated = true;
	}
	
	private var _name:String;
	
	public function ViewSessionEventType(name:String)
	{
		_name = name;
	}
	
	public static function forName(value:String):ViewSessionEventType 
	{
		switch (value)
		{
			case VIDEO_STOPPED_KEY:
				return VIDEO_STOPPED;
				
			case VIDEO_STARTED_KEY:
				return VIDEO_STARTED;
				
			case VIDEO_PAUSED_KEY:
				return VIDEO_PAUSED;
			
			case COMPONENT_CLICKED_KEY:
				return COMPONENT_CLICKED;
				
			case OPERATION_EXECUTED_KEY:
				return OPERATION_EXECUTED;
				
			default:
				throw new Error("There is no ViewSessionEventType for the value '" + value + "'");
		}
	}
	
	public function toString():String 
	{
		return _name;
	}*/
}
package xuloo.ui;
	
class Versions implements IVersions
{	
	public static var QTV_PLAY_WEBAPP_VERSION:String = "qtvPlayWebappVersion";
	public static var QTV_WEBAPP_CLIENT_VERSION:String = "qtvWebappClientVersion";
	public static var QTV_FLEX_CORE_VERSION:String = "qtvFlexCoreVersion";
	public static var QTV_INTERACTIVE_VIDEO_PLAYER_VERSION:String = "qtvInteractiveVideoPlayerVersion";
	
	private var _versions:Hash<String>;
	
	public function new(arg:Dynamic)
	{
		_versions = new Hash<String>();
		
		if (Std.is(arg, FlashVars))
		{
			var flashVars:FlashVars = cast(arg, FlashVars);
			_versions.set(QTV_PLAY_WEBAPP_VERSION, flashVars.getOrElse(QTV_PLAY_WEBAPP_VERSION, "No version defined for '" + QTV_PLAY_WEBAPP_VERSION + "'"));
			_versions.set(QTV_WEBAPP_CLIENT_VERSION, flashVars.getOrElse(QTV_WEBAPP_CLIENT_VERSION, "No version defined for '" + QTV_WEBAPP_CLIENT_VERSION + "'"));
			_versions.set(QTV_FLEX_CORE_VERSION, flashVars.getOrElse(QTV_FLEX_CORE_VERSION, "No version defined for '" + QTV_FLEX_CORE_VERSION + "'"));
			_versions.set(QTV_INTERACTIVE_VIDEO_PLAYER_VERSION, flashVars.getOrElse(QTV_INTERACTIVE_VIDEO_PLAYER_VERSION, "No version defined for '" + QTV_INTERACTIVE_VIDEO_PLAYER_VERSION + "'"));
		}
		else if (Std.is(arg, Properties))
		{
			var properties:Properties = cast(arg, Properties);
			_versions.set(QTV_PLAY_WEBAPP_VERSION, properties.getStringProperty("play.webapp.version"));
			_versions.set(QTV_WEBAPP_CLIENT_VERSION, properties.getStringProperty("webapp.client.version"));
			_versions.set(QTV_FLEX_CORE_VERSION, properties.getStringProperty("flex.core.version"));
			_versions.set(QTV_INTERACTIVE_VIDEO_PLAYER_VERSION, properties.getStringProperty("interactive.video.player.version"));
		}
	}
	
	public function getValue(key:String):IOption<String>
	{
		if (_versions.exists(key)) {
			return new Something<String>(_versions.get(key));
		}
		
		return new Nothing<String>();
	}
}
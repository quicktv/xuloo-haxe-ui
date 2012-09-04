package xuloo.ui;

interface IJSON {
	
	function fromJson(json:Dynamic, ?useCache:Bool = true):Dynamic;
	
	function toJson(?escapeStrings:Bool = false):String;
}
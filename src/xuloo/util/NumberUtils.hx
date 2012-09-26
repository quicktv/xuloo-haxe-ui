package xuloo.util;

/**
 * ...
 * @author Trevor B
 */

class NumberUtils 
{
	public static function dec2hex(dec:Int):String {
		var hex:String = '';
		var arr:String = 'FEDCBA';
		var len:Int = decBinLen(dec);
		
		// Making sure it can at least match a single hex digit;
		
		if((len % 4) > 0){
			while((len % 4) > 0){
				len++;
			}
		}
		
		len = cast(len / 4, Int);
		
		// Just for fun: making sure it is at least a byte, a word, or a dword. If you want just the exact hexadecimal count, comment this loop out.
		
		if((len % 4) > 0){
			while((len % 4) > 0){
				len++;
			}
		}
		
		//for(var i:uint = 0; i < len; i++) {
		for (i in 0...len) {
			if(((dec & (0x0F << (i * 4))) >> (i * 4)) > 9){
				hex = arr.charAt(15 - ((dec & (0x0F << (i * 4))) >> (i * 4))) + hex;
			}
			else{
				hex = Std.string((((dec & (0x0F << (i * 4))) >> (i * 4))) + hex);
			}
		}
		
		if(hex == ''){
			hex = '0000';
		}
		
		return hex;
	}
	
	public static function decBinLen(dec:Int):Int {
		var len:Int = 0;
		var check = true;
		if(dec != 0){
			len = 1;
			while(check){
				if((dec >> len) == 0){
					check = false;
				}
				else{
					len++;
				}
			}
		}
		
		return len;
	}
	
	public function new() 
	{
		
	}
	
}
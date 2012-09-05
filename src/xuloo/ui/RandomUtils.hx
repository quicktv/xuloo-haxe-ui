package xuloo.ui;

class RandomUtils
{
	public function new() {
	}
	
	public static function randomString(?newLength:Int = 1, ?userAlphabet:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"):String {
		var alphabet:Array<String> = userAlphabet.split("");
		var alphabetLength:Int = alphabet.length;
		var randomLetters:String = "";
		
		for (i in 0...newLength){
			randomLetters += alphabet[Math.floor(Math.random() * alphabetLength)];
		}
		
		return randomLetters;
	}
}
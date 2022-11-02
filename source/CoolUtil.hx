package;

import lime.utils.Assets;
import flixel.FlxG;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', 'NORMAL', 'HARD'];

	public static inline final defaultDifficulty:String = 'NORMAL'; // no suffix

	public static function difficultyString():String
	{
		if(PlayState.storyDifficulty == difficultyArray.length) // no crash
			return defaultDifficulty;
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	inline public static function isInState(state:String)
	{
		return Type.getClassName(Type.getClass(FlxG.state)).contains(state);
	}
}

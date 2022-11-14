package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxAxes;
import lime.utils.Assets;

using StringTools;

enum SlideCalcMethod
{
	SIN;
	COS;
}

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', 'NORMAL', 'HARD'];

	public static inline final defaultDifficulty:String = 'NORMAL'; // no suffix

	public static function difficultyString():String
	{
		if (PlayState.storyDifficulty == difficultyArray.length) // no crash
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

	public static function slideEffect(amplitude:Float, calcMethod:SlideCalcMethod, slowness:Float = 1, delayIndex:Float = 0, ?offset:Float):Float
	{
		if (slowness > 0)
		{
			var slider:Float = (FlxG.sound.music.time / 1000) * (Conductor.bpm / 60);

			while (delayIndex >= 2)
			{
				delayIndex -= 2;
			}

			var slideValue:Float;

			switch (calcMethod)
			{
				case SIN:
					slideValue = offset + amplitude * Math.sin(((slider + delayIndex) / slowness) * Math.PI);
				case COS:
					slideValue = offset + amplitude * Math.cos(((slider + delayIndex) / slowness) * Math.PI);
				default:
					throw 'The current calc method for the slide effect function is not valid!';
			}

			return slideValue;
		}
		else
			throw 'Slide Effect slowness value cannot be less than 0!';
	}

	public static function objectCenter(object:FlxObject, target:FlxObject, axis:FlxAxes = XY)
	{
		if (axis == XY || axis == X)
			object.x = target.x + target.width / 2 - object.width / 2;
		if (axis == XY || axis == Y)
			object.y = target.y + target.height / 2 - object.height / 2;
	}

	inline public static function isInState(state:String)
	{
		return Type.getClassName(Type.getClass(FlxG.state)).contains(state);
	}

	public static function addSprite(x, y, path:String, scrollFactor:Float = 1, ?antialiasing:Bool = true, daState:FlxState):FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.image(path));
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		sprite.active = false;
		sprite.antialiasing = antialiasing;
		daState.add(sprite);
		return sprite;
	}

	public static function setSpr(name:String, sprite:FlxSprite):FlxSprite
	{
		theSprites.set(name, sprite);
		return theSprites.get(name);
	}

	public static function getSpr(name:String):FlxSprite
	{
		return theSprites.get(name);
	}

	public static function addAnimPrefix(x, y, path:String, prefix:String, scrollFactor:Float = 1, loop:Bool = true, fps:Int = 24,
			?antialiasing:Bool = true, daState:FlxState):FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.frames = Paths.getSparrowAtlas(path);
		sprite.animation.addByPrefix(prefix, prefix, fps, loop);
		sprite.animation.play(prefix);
		sprite.antialiasing = antialiasing;
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		daState.add(sprite);
		return sprite;
	}

	public static function addAnimIndices(x, y, path:String, prefix:String, indices:Array<Int>, scrollFactor:Float = 1, loop:Bool = true, fps:Int = 24,
			?antialiasing:Bool = true, daState:FlxState):FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.frames = Paths.getSparrowAtlas(path);
		sprite.animation.addByIndices(prefix, prefix, indices, "", fps, loop);
		sprite.animation.play(prefix);
		sprite.antialiasing = antialiasing;
		sprite.scrollFactor.set(scrollFactor, scrollFactor);
		daState.add(sprite);
		return sprite;
	}
}

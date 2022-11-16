package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import flixel.graphics.FlxGraphic;
import Cache.AtlasType;

using StringTools;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	public static var currentTrackedAssets:Map<String, FlxGraphic> = [];

	public static var localTrackedAssets:Array<String> = [];

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, ?type:AssetType, ?library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	inline static public function jsonAnywhere(key:String, ?library:String)
	{
		return getPath('$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function video(key:String, ?library:String)
	{
		return ('assets/videos/$key.mp4');
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function voices(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function hscript(key:String, ?library:String)
	{
		return getPath('data/$key.hx', TEXT, library);
	}

	inline static public function formatToSongPath(path:String)
	{
		return path.toLowerCase().replace(' ', '-');
	}

	inline static public function getSparrowAtlas(key:String, ?library:String, persistUntilClear:Bool = false)
	{
		return returnAtlas('images/$key', Sparrow, library, persistUntilClear);
	}

	inline static public function getPackerAtlas(key:String, ?library:String, persistUntilClear:Bool = false)
	{
		return returnAtlas('images/$key', Packer, library, persistUntilClear);
	}

	inline static public function getSparrowAtlasLegacy(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlasLegacy(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}

	// Credit: MAJigsaw77
	public static function returnGraphic(key:String, ?cache:Bool = true):FlxGraphic
	{
		var path:String = 'assets/$key.png';
		if (OpenFlAssets.exists(path, IMAGE))
		{
			if (!currentTrackedAssets.exists(path))
			{
				var graphic:FlxGraphic = FlxGraphic.fromBitmapData(OpenFlAssets.getBitmapData(path), false, path, cache);
				graphic.persist = true;
				currentTrackedAssets.set(path, graphic);
			}

			localTrackedAssets.push(path);
			return currentTrackedAssets.get(path);
		}

		trace('oh no $key its returning null NOOOO');
		return null;
	}

	// Credit: Stilic
	public static function returnAtlas(key:String, type:AtlasType, ?library:String, persistUntilClear:Bool = false)
	{
		var path = getPath('$key.png', IMAGE, library);
		var atlas = Cache.getAtlas(path, type);
		if (atlas != null)
		{
			if (persistUntilClear)
				Cache.persistantAssets.set(path, true);
			return atlas;
		}

		trace('oh no ${key} is returning null NOOOO');
		return null;
	}
}

package;

import openfl.utils.Assets;
import openfl.display.BitmapData;
import openfl.media.Sound;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxSound;
import flixel.util.FlxDestroyUtil;
import ui.AtlasText;
import ui.PreferencesMenu;

using StringTools;

class Cache
{
	public static var persistantAssets:Map<String, Bool> = [
		'music/freakyMenu.${Paths.SOUND_EXT}' => false,
		'music/breakfast.${Paths.SOUND_EXT}' => false
	];

	public static function isPersistant(path:String)
	{
		for (key in persistantAssets.keys())
		{
			if (path.endsWith(key))
				return true;
		}
		return false;
	}

	static var images:Map<String, CoolImage> = [];
	static var atlases:Map<String, CoolAtlas> = [];
	static var sounds:Map<String, Sound> = [];

	public static function getGraphic(id:String)
	{
		if (hasGraphic(id))
			return images.get(id).graphic;

		if (Assets.exists(id, IMAGE))
		{
			var image:CoolImage = new CoolImage(id, PreferencesMenu.getPref('gpu-rendering'));
			images.set(id, image);
			return image.graphic;
		}
		return null;
	}

	public static function getAtlas(id:String, type:AtlasType)
	{
		if (hasAtlas(id, type))
			return atlases.get(id).atlas;

		var path:String = id;
		if (!path.endsWith('.png'))
			path += '.png';
		var image:FlxGraphic = getGraphic(path);
		if (image != null)
		{
			path = path.substring(0, path.length - 4);
			var atlas:FlxAtlasFrames = null;
			switch (type)
			{
				case Sparrow:
					path += '.xml';
					atlas = FlxAtlasFrames.fromSparrow(image, path);

				case Packer:
					path += '.txt';
					atlas = FlxAtlasFrames.fromSpriteSheetPacker(image, path);
			}
			if (atlas != null)
			{
				atlases.set(id, {atlas: atlas, type: type});
				return atlas;
			}
		}
		return null;
	}

	#if lime_vorbis
	// music streaming stuff
	public static function getMusic(id:String)
	{
		if (hasSound(id))
			return sounds.get(id);

		if (Assets.exists(id, SOUND))
		{
			var music = Assets.getMusic(id, false);
			sounds.set(id, music);
			return music;
		}
		return null;
	}
	#end

	public static function getSound(id:String)
	{
		if (hasSound(id))
			return sounds.get(id);

		if (Assets.exists(id, SOUND))
		{
			var sound = Assets.getSound(id);
			sounds.set(id, sound);
			return sound;
		}
		return null;
	}

	inline public static function hasGraphic(id:String)
	{
		return images.exists(id);
	}

	inline public static function hasAtlas(id:String, ?type:AtlasType)
	{
		return atlases.exists(id) && (type == null || atlases.get(id).type == type);
	}

	inline public static function hasSound(id:String)
	{
		return sounds.exists(id);
	}

	public static function removeGraphic(id:String)
	{
		if (hasGraphic(id))
		{
			removeAtlas(id);
			FlxDestroyUtil.destroy(images.get(id));
			images.remove(id);
			return true;
		}
		return false;
	}

	public static function removeAtlas(id:String, ?type:AtlasType)
	{
		if (hasAtlas(id, type))
		{
			var atlasData = atlases.get(id);
			atlasData.atlas = FlxDestroyUtil.destroy(atlasData.atlas);
			atlases.remove(id);
			return true;
		}
		return false;
	}

	public static function removeSound(id:String)
	{
		if (hasSound(id))
		{
			#if !html5 sounds.get(id).close(); #end
			sounds.remove(id);
			Assets.cache.removeSound(id);
			return true;
		}
		return false;
	}

	public static function clear()
	{
		AtlasText.clearCache();

		for (key => shoudRemove in persistantAssets)
		{
			if (shoudRemove)
				persistantAssets.remove(key);
		}

		for (key in images.keys())
		{
			if (!isPersistant(key))
				removeGraphic(key);
		}

		// clear the flixel cache manually since the clearCache function is dumb
		@:privateAccess
		for (graphic in FlxG.bitmap._cache)
		{
			if (!isPersistant(graphic.key))
				CoolUtil.destroyGraphic(graphic);
		}

		clearUnusedSounds();

		CoolUtil.runGC();
	}

	public static function clearUnused()
	{
		for (key => image in images)
		{
			if (image.graphic.useCount <= 0 && !isPersistant(key))
				removeGraphic(key);
		}

		clearUnusedSounds();

		CoolUtil.runGC();
	}

	static function clearUnusedSounds()
	{
		var usedSounds:Array<Sound> = [];

		FlxG.sound.list.forEachAlive(function(sound:FlxSound)
		{
			@:privateAccess
			if (sound._sound != null && !usedSounds.contains(sound._sound))
				usedSounds.push(sound._sound);
		});

		@:privateAccess
		if (FlxG.sound.music != null && FlxG.sound.music._sound != null && !usedSounds.contains(FlxG.sound.music._sound))
			usedSounds.push(FlxG.sound.music._sound);

		for (key in sounds.keys())
		{
			if (!usedSounds.contains(sounds.get(key)) && !isPersistant(key))
				removeSound(key);
		}
	}
}

class CoolImage implements IFlxDestroyable
{
	public var graphic(default, null):FlxGraphic;

	public function new(path:String, gpuCache:Bool = false)
	{
		var bitmap = Assets.getBitmapData(path);
		if (gpuCache)
		{
			bitmap.lock();
			var texture = FlxG.stage.context3D.createRectangleTexture(bitmap.width, bitmap.height, BGRA, true);
			texture.uploadFromBitmapData(bitmap);
			bitmap.disposeImage();
			FlxDestroyUtil.dispose(bitmap);
			bitmap = BitmapData.fromTexture(texture);
			Assets.cache.setBitmapData(path, bitmap);
		}

		graphic = FlxGraphic.fromBitmapData(bitmap, false, path);
		graphic.persist = true;
	}

	public function destroy()
	{
		graphic = CoolUtil.destroyGraphic(graphic);
	}
}

typedef CoolAtlas =
{
	var atlas:FlxAtlasFrames;
	var type:AtlasType;
}

enum AtlasType
{
	Sparrow;
	Packer;
}

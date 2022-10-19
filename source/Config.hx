package;

import flixel.FlxG;

using StringTools;

// I borrowed this from FPS Plus https://github.com/ThatRozebudDude/FPS-Plus-Public
// thank you rozebud

class Config
{
	public static var downscroll:Bool;
	public static var healthBarColors:Bool;
	public static var ghostTapping:Bool;

	public static function resetSettings():Void
	{
		FlxG.save.data.downscroll = false;
		FlxG.save.data.ghostTapping = false;
		reload();
	}

	public static function reload():Void
	{
		ghostTapping = FlxG.save.data.ghostTapping;
		downscroll = FlxG.save.data.downscroll;
        healthBarColors = FlxG.save.data.healthBarColors;
	}

	public static function write(downscrollW:Bool, ghostTappingW:Bool, healthBarColorsW:Bool):Void
	{
		FlxG.save.data.downscroll = downscrollW;
		FlxG.save.data.ghostTapping = ghostTappingW;
		FlxG.save.data.healthBarColors = healthBarColorsW;

		FlxG.save.flush();

		reload();
	}

	public static function configCheck():Void
	{
		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;
		if (FlxG.save.data.healthBarColors == null)
			FlxG.save.data.healthBarColors = false;
		if (FlxG.save.data.ghostTapping == null)
			FlxG.save.data.ghostTapping = false;
	}
}

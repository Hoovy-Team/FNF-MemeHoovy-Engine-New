package;

import flixel.FlxG;

using StringTools;

// I borrowed this from FPS Plus https://github.com/ThatRozebudDude/FPS-Plus-Public
// thank you rozebud
class Config
{
	public static var downscroll:Bool = false;
	public static var healthBarColors:Bool = true;
	public static var ghostTapping:Bool = true;
	public static var globalAntialiasing:Bool = true;

	public static function resetSettings():Void
	{
		// this is supposed to RESET settings, but it doesn't work so I reverted it to the way it was
		// not calling you a bad coder wither, but it didn't work the way you changed it to -memehoovy
		FlxG.save.data.healthBarColors = true;
		FlxG.save.data.downscroll = false;
		FlxG.save.data.ghostTapping = true;
		FlxG.save.data.globalAntialiasing = true;
		reload();
	}

	public static function reload():Void
	{
		globalAntialiasing = FlxG.save.data.globalAntialiasing;
		ghostTapping = FlxG.save.data.ghostTapping;
		downscroll = FlxG.save.data.downscroll;
		healthBarColors = FlxG.save.data.healthBarColors;
	}

	public static function write(downscrollW:Bool = false, ghostTappingW:Bool = true, healthBarColorsW:Bool = true, globalAntialiasingW:Bool = true):Void
	{
		FlxG.save.data.downscroll = downscrollW;
		FlxG.save.data.ghostTapping = ghostTappingW;
		FlxG.save.data.healthBarColors = healthBarColorsW;
		FlxG.save.data.globalAntialiasing = globalAntialiasingW;

		FlxG.save.flush();

		reload();
	}

	public static function configCheck():Void
	{
		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = downscroll;
		if (FlxG.save.data.healthBarColors == null)
			FlxG.save.data.healthBarColors = healthBarColors;
		if (FlxG.save.data.ghostTapping == null)
			FlxG.save.data.ghostTapping = ghostTapping;
		if (FlxG.save.data.globalAntialiasing == null)
			FlxG.save.data.globalAntialiasing = globalAntialiasing;
	}
}

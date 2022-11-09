package;

import flixel.FlxG;

using StringTools;

// I borrowed this from FPS Plus https://github.com/ThatRozebudDude/FPS-Plus-Public
// thank you rozebud
class Config
{
	public static var downscroll:Bool = false;
	public static var healthBarColors:Bool = true;
	public static var ghostTapping:Bool = false;

	public static function resetSettings():Void
	{
		FlxG.save.data.healthBarColors = healthBarColors;
		FlxG.save.data.downscroll = downscroll;
		FlxG.save.data.ghostTapping = ghostTapping;
		reload();
	}

	public static function reload():Void
	{
		ghostTapping = FlxG.save.data.ghostTapping;
		downscroll = FlxG.save.data.downscroll;
		healthBarColors = FlxG.save.data.healthBarColors;
	}

	public static function write(downscrollW:Bool = false, ghostTappingW:Bool = false, healthBarColorsW:Bool = true):Void
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
			FlxG.save.data.downscroll = downscroll;
		if (FlxG.save.data.healthBarColors == null)
			FlxG.save.data.healthBarColors = healthBarColors;
		if (FlxG.save.data.ghostTapping == null)
			FlxG.save.data.ghostTapping = ghostTapping;
	}
}

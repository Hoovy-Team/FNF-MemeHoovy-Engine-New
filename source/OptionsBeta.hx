package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class OptionsBeta extends MusicBeatState
{
	// I'm coming so close to just recreating this shit from the ground up, it's buggy af
	var option_gt:FlxText;
	var option_hpc:FlxText;
	var option_downscroll:FlxText;
	var option_globalAntialiasing:FlxText;

	public static var downValue:Bool = false;
	public static var ghostValue:Bool = false;
	public static var healthColorsValue:Bool = false;
	public static var globalAntialiasing:Bool = true;

	var seenWarning:Bool = false;

	final doReset:Bool = true; // for debugging purposes

	var warning:FlxText = new FlxText(0,0,0, 'WARNING, your save data will be resetted.\nDo you wish to continue?',32);
	var blackScreen:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);

	override function create() // this takes alot of code from my cookie clicker game huh
	{
		super.create();
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		Config.reload();

		option_gt = new FlxText(0, 100, 0, "n/a", 30);
		option_gt.pixelPerfectPosition = true;
		option_gt.borderColor = FlxColor.BLACK;
		option_gt.borderSize = 3;
		option_gt.borderStyle = OUTLINE;
		option_gt.screenCenter(X);
		add(option_gt);

		option_hpc = new FlxText(0, 200, 0, "n/a", 30);
		option_hpc.pixelPerfectPosition = true;
		option_hpc.borderColor = FlxColor.BLACK;
		option_hpc.borderSize = 3;
		option_hpc.borderStyle = OUTLINE;
		option_hpc.screenCenter(X);
		add(option_hpc);

		option_downscroll = new FlxText(0, 300, 0, "n/a", 30);
		option_downscroll.pixelPerfectPosition = true;
		option_downscroll.borderColor = FlxColor.BLACK;
		option_downscroll.borderSize = 3;
		option_downscroll.borderStyle = OUTLINE;
		option_downscroll.screenCenter(X);
		add(option_downscroll);

		option_globalAntialiasing = new FlxText(0, 400, 0, "n/a", 30);
		option_globalAntialiasing.pixelPerfectPosition = true;
		option_globalAntialiasing.borderColor = FlxColor.BLACK;
		option_globalAntialiasing.borderSize = 3;
		option_globalAntialiasing.borderStyle = OUTLINE;
		option_globalAntialiasing.screenCenter(X);
		add(option_globalAntialiasing);

		FlxG.mouse.visible = true;
		FlxG.mouse.enabled = true;

		downValue = Config.downscroll;
		ghostValue = Config.ghostTapping;
		healthColorsValue = Config.healthBarColors;
		globalAntialiasing = Config.globalAntialiasing;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.overlaps(option_gt) && FlxG.mouse.justPressed)
		{
			ghostValue = !ghostValue;
			writeToConfig();
		}

		if (FlxG.mouse.overlaps(option_hpc) && FlxG.mouse.justPressed)
		{
			healthColorsValue = !healthColorsValue;
			writeToConfig();
		}

		if (FlxG.mouse.overlaps(option_downscroll) && FlxG.mouse.justPressed)
		{
			downValue = !downValue;
			writeToConfig();
		}

		if (FlxG.mouse.overlaps(option_globalAntialiasing) && FlxG.mouse.justPressed)
		{
			globalAntialiasing = !globalAntialiasing;
			writeToConfig();
		}

		if (ghostValue)
		{
			option_gt.text = "Ghost Tapping: true";
		}
		else
		{
			option_gt.text = "Ghost Tapping: false";
		}

		if (healthColorsValue)
		{
			option_hpc.text = "Health Colors: true";
		}
		else
		{
			option_hpc.text = "Health Colors: false";
		}

		if (downValue)
		{
			option_downscroll.text = "Downscroll: true";
		}
		else
		{
			option_downscroll.text = "Downscroll: false";
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MainMenuState());
			FlxG.mouse.visible = false;
			FlxG.mouse.enabled = false;
			// Config.resetSettings();
			writeToConfig();
		}

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			if (!seenWarning) {
				if (blackScreen != null)
					FlxTween.tween(blackScreen, {alpha: 0.5}, 0.7, {ease: FlxEase.linear});

				if (warning != null)
					FlxTween.tween(warning, {alpha: 1.0}, 0.7, {ease: FlxEase.linear});

				add(blackScreen);
				add(warning);

				seenWarning = true;
			} else {
				if (FlxG.keys.justPressed.ENTER) {
					FlxG.switchState(new MainMenuState());
					FlxG.mouse.visible = false;
					FlxG.mouse.enabled = false;
					if (doReset)
						Config.resetSettings();
					// writeToConfig();
					remove(blackScreen);
					remove(warning);
					seenWarning = false;
				}
				else if (FlxG.keys.justPressed.ESCAPE){
					remove(blackScreen);
					remove(warning);
					seenWarning = false;
				}
			}
		}
		super.update(elapsed);
	}

	function writeToConfig()
	{
		Config.write(downValue, ghostValue, healthColorsValue, globalAntialiasing);
	}
}

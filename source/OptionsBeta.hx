package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class OptionsBeta extends MusicBeatState
{
    // I'm coming so close to just recreating this shit from the ground up, it's buggy af
    var option_gt:FlxText;
    var option_hpc:FlxText;
    var option_downscroll:FlxText;
    // public static var option_gt_int:Int = 0;
    // public static var option_hpc_int:Int = 0;
    // public static var option_downscroll_int:Int = 0;
    // public static var option_downscroll_bool:Bool = false;

    public static var downValue:Bool = false;
    public static var ghostValue:Bool = false;
    public static var healthColorsValue:Bool = false;

    override function create()//this takes alot of code from my cookie clicker game huh
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

        FlxG.mouse.visible = true;
        FlxG.mouse.enabled = true;

        downValue = Config.downscroll;
        ghostValue = Config.ghostTapping;
        healthColorsValue = Config.healthBarColors;

        // if (FlxG.save.data.option_gt_int != option_gt_int)
		// 	option_gt_int = FlxG.save.data.option_gt_int;
        // if (FlxG.save.data.option_hpc_int != option_hpc_int)
		// 	option_hpc_int = FlxG.save.data.option_hpc_int;
        // if (FlxG.save.data.option_downscroll_int != option_downscroll_int)
		// 	option_downscroll_int = FlxG.save.data.option_downscroll_int;
        // if (FlxG.save.data.option_downscroll_bool != option_downscroll_bool) {
		// 	option_downscroll_bool = FlxG.save.data.option_downscroll_bool;
        //     downScrollEnabled = option_downscroll_bool;
        // }
        super.create();
    }

    override public function update(elapsed:Float)
    {
        if(FlxG.mouse.overlaps(option_gt) && FlxG.mouse.justPressed)
        {
            ghostValue = !ghostValue;
            writeToConfig();
        }

        if(FlxG.mouse.overlaps(option_hpc) && FlxG.mouse.justPressed)
        {
            healthColorsValue = !healthColorsValue;
            writeToConfig();
        }

        if(FlxG.mouse.overlaps(option_downscroll) && FlxG.mouse.justPressed)
        {
            downValue = !downValue;
            writeToConfig();
        }

        if(ghostValue)
        {
            option_gt.text = "Ghost Tapping: true";
        }
        else
        {
            option_gt.text = "Ghost Tapping: false";
        }

        if(healthColorsValue)
        {
            option_hpc.text = "Health Colors: true";
        }
        else
        {
            option_hpc.text = "Health Colors: false";
        }

        if(downValue)
        {
            option_downscroll.text = "Downscroll: true";
        }
        else
        {
            option_downscroll.text = "Downscroll: false";
        }

        // if(option_gt_int > 1)
        //     option_gt_int = 1;
        // if(option_gt_int < 0)
        //     option_gt_int = 0;
        // if(option_hpc_int > 1)
        //     option_hpc_int = 1;
        // if(option_hpc_int < 0)
        //     option_hpc_int = 0;
        // if(option_downscroll_int > 1)
        //     option_downscroll_int = 1;
        // if(option_downscroll_int < 0)
        //     option_downscroll_int = 0;
        if(FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new MainMenuState());
            FlxG.mouse.visible = false;
            FlxG.mouse.enabled = false;
            // Config.resetSettings();
            writeToConfig();
        }
        super.update(elapsed);
    }

	function writeToConfig(){
		Config.write(downValue, ghostValue, healthColorsValue);
	}    
}
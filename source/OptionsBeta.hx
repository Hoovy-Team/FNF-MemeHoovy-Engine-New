package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class OptionsBeta extends MusicBeatState
{
    var option_gt:FlxText;
    var option_hpc:FlxText;
    var option_wus:FlxText;
    public static var option_gt_int:Int = 1;
    public static var option_hpc_int:Int = 1;
    public static var option_wus_int:Int = 0;
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

        option_wus = new FlxText(0, 200, 0, "n/a", 30);
		option_wus.pixelPerfectPosition = true;
		option_wus.borderColor = FlxColor.BLACK;
		option_wus.borderSize = 3;
		option_wus.borderStyle = OUTLINE;
        option_wus.screenCenter(X);
		add(option_wus);

        FlxG.mouse.visible = true;
        FlxG.mouse.enabled = true;

        if (FlxG.save.data.option_gt_int != option_gt_int)
			option_gt_int = FlxG.save.data.option_gt_int;
        if (FlxG.save.data.option_hpc_int != option_hpc_int)
			option_hpc_int = FlxG.save.data.option_hpc_int;
        if (FlxG.save.data.option_wus_int != option_wus_int)
			option_hpc_int = FlxG.save.data.option_wus_int;
        super.create();
    }

    override public function update(elapsed:Float)
    {
        if(option_gt_int == 1)
        {
            option_gt.text = "Ghost Tapping: true";
        }
        else if(option_gt_int == 0)
        {
            option_gt.text = "Ghost Tapping: false";
        }
        if(option_hpc_int == 1)
        {
            option_hpc.text = "Health Colors: true";
        }
        else if(option_hpc_int == 0)
        {
            option_hpc.text = "Health Colors: false";
        }
        if(option_wus_int == 1)
        {
            option_wus.text = "Week Unlock System: true";
        }
        else if(option_wus_int == 0)
        {
            option_hpc.text = "Week Unlock System: true";
        }
        if(FlxG.mouse.overlaps(option_gt) && FlxG.keys.justPressed.ENTER)
        {
            option_gt_int++;
            FlxG.save.data.option_gt_int = option_gt_int;
        }
        if (FlxG.mouse.overlaps(option_gt) && FlxG.keys.justPressed.BACKSPACE)
        {
            option_gt_int--;
            FlxG.save.data.option_gt_int = option_gt_int;
        }
        if(FlxG.mouse.overlaps(option_hpc) && FlxG.keys.justPressed.ENTER)
        {
            option_hpc_int++;
            FlxG.save.data.option_hpc_int = option_hpc_int;
        }
        if (FlxG.mouse.overlaps(option_hpc) && FlxG.keys.justPressed.BACKSPACE)
        {
            option_hpc_int--;
            FlxG.save.data.option_hpc_int = option_hpc_int;
        }
        if(FlxG.mouse.overlaps(option_wus) && FlxG.keys.justPressed.ENTER)
        {
            option_wus_int++;
            FlxG.save.data.option_wus_int = option_wus_int;
        }
        if (FlxG.mouse.overlaps(option_wus) && FlxG.keys.justPressed.BACKSPACE)
        {
            option_wus_int--;
            FlxG.save.data.option_wus_int = option_hpc_int;
        }
        if(option_gt_int > 1)
            option_gt_int = 1;
        if(option_gt_int < 0)
            option_gt_int = 0;
        if(option_hpc_int > 1)
            option_hpc_int = 1;
        if(option_hpc_int < 0)
            option_hpc_int = 0;
        if(option_wus_int < 0)
            option_wus_int = 0;
        if(FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new MainMenuState());
            FlxG.mouse.visible = false;
            FlxG.mouse.enabled = false;
        }
        super.update(elapsed);
    }
}
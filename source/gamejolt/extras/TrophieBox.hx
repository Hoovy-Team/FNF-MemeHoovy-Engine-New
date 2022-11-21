package gamejolt.extras;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.utils.Assets;
import ui.PreferencesMenu;

class TrophieBox extends FlxUIGroup
{
    // Display Stuff
    var titleBox:FlxText;
    var descBox:FlxText;
    var dateBox:FlxText;
    var daImage:FlxSprite;
    var daBG:FlxSprite;

    // Size Parameters
    var boxWidth:Int = Std.int(FlxG.width * 0.6);
    var boxHeight:Int = Std.int(FlxG.height * 0.275);

    // Fonts
    var titleFont:String = Paths.font("pixel.otf");
    var descFont:String = "VCR OSD Mono";
    var dateFont:String = "VCR OSD Mono";

    //Sizes
    var titleSize:Int = 32;
    var descSize:Int = 24;
    var dateSize:Int = 16;

    public function new(title:String, desc:String, date:String, x:Float = 0, y:Float = 0, ?image:String, ?bg:String)
    {
        super(x, y);

        if (Assets.exists(Std.string(Paths.image(Std.string(bg)))) && bg != null)
        {
            daBG = new FlxSprite().loadGraphic(Paths.image(bg));
            daBG.setGraphicSize(boxWidth, boxHeight);
            daBG.updateHitbox();
        }
        else
        {
            daBG = new FlxSprite().makeGraphic(boxWidth, boxHeight, FlxColor.BLACK);
            daBG.alpha = 0.65;
        }

        if (Assets.exists(Std.string(Paths.image(Std.string(image)))) && image != null)
            daImage = new FlxSprite().loadGraphic(Paths.image(image));
        else daImage = new FlxSprite().loadGraphic(Paths.image('unknownMod'));

        var imgScale:Int = Std.int(daBG.height * (3/5));

        daImage.setGraphicSize(imgScale, imgScale);
        daImage.updateHitbox();
        daImage.x = daImage.width / 5;
        daImage.y = (daBG.height/2) - (daImage.height/2);

        var separation:Float = (daImage.x * 2) + daImage.width;
        var delimitation:Float = daBG.width - separation - daImage.x;

        titleBox = new FlxText(separation, 0, delimitation, title);
        titleBox.setFormat(titleFont, titleSize, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        titleBox.textField.multiline = false;
        titleBox.borderColor = FlxColor.BLACK;
        titleBox.y = (daBG.height * (1/4)) - (titleBox.height / 2.5);

        dateBox = new FlxText(separation, 0, delimitation, date);
        dateBox.setFormat(dateFont, dateSize, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        dateBox.textField.multiline = false;
        dateBox.borderColor = FlxColor.BLACK;
        dateBox.y = (daBG.height * (3/4)) - (dateBox.height / 2.5);

        descBox = new FlxText(separation, 0, delimitation, desc);
        descBox.setFormat(descFont, descSize, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        descBox.textField.multiline = false;
        descBox.borderColor = FlxColor.BLACK;
        descBox.y = titleBox.y + ((dateBox.y + dateBox.height - titleBox.y) / 2);

        add(daBG);
        add(daImage);
        add(titleBox);
        add(descBox);
        add(dateBox);

        antialiasing = PreferencesMenu.getPref('global-antialiasing');
    }
}